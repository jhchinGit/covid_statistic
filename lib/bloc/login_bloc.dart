import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/models/models.dart';
import 'package:covid_statistic/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokenRepository repository;

  LoginBloc({@required this.repository}) : assert(repository != null);

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
        final String result =
            await repository.fetchToken(event.username, event.password);
        yield LoginLoaded(isLogin: true);
      } catch (_) {
        yield LoginError(errorMessage: "Fail to retrieve token.");
      }
    }
    // if (event is FetchIndiaCovidReport) {
    //   yield LoginLoading();
    //   try {
    //     final Login Login = await repository.fetchIndiaCovidReport();
    //     yield LoginLoaded(Login: Login);
    //   } catch (_) {
    //     yield LoginError();
    //   }
    // }
  }
}
