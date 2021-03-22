import 'dart:async';
import 'package:covid_statistic/repositories/login_api_client.dart';
import 'package:meta/meta.dart';

class LoginRepository {
  final LoginApiClient loginApiClient;

  LoginRepository({@required this.loginApiClient})
      : assert(loginApiClient != null);

  Future<bool> fetchLogin(String username, String authenticationCode) async =>
      await loginApiClient.fetchLogin(username, authenticationCode);
}
