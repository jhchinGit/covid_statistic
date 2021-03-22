import 'package:covid_statistic/repositories/login_repository.dart';
import 'package:covid_statistic/utilities/token_helper.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokenRepository tokenRepository;
  final LoginRepository loginRepository;

  LoginBloc({@required this.tokenRepository, @required this.loginRepository})
      : assert(tokenRepository != null, loginRepository != null);

  @override
  LoginState get initialState => LoginEmpty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLogin) {
      if (event.username == "" || event.password == "") {
        yield LoginError(
            errorMessage: "Please key in your username and password.");
      } else if (event.authenticationCode == "") {
        yield LoginError(
            errorMessage: "Please key in your authentication code.");
      }
      yield LoginLoading();

      try {
        final accessToken = await tokenRepository.fetchToken(
            event.username, event.password, event.authenticationCode);

        if (await TokenHelper.saveToken(accessToken) &&
            await loginRepository.fetchLogin(
                event.username, event.authenticationCode)) {
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
