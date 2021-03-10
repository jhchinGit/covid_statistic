import 'package:covid_statistic/models/models.dart';
import 'package:covid_statistic/utilities/token_helper.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokenRepository tokenRepository;

  LoginBloc({@required this.tokenRepository}) : assert(tokenRepository != null);

  @override
  LoginState get initialState => LoginEmpty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLogin) {
      if (event.username == "" || event.password == "") {
        yield LoginError(
            errorMessage: "Please key in your username and password.");
      }
      yield LoginLoading();

      try {
        final accessToken =
            await tokenRepository.fetchToken(event.username, event.password);

        if (await TokenHelper.saveToken(accessToken)) {
          yield LoginLoaded(isLogin: true);
        } else {
          yield LoginError(errorMessage: "Fail to save token");
        }
      } catch (_) {
        yield LoginError(errorMessage: _.message);
      }
    }
  }
}
