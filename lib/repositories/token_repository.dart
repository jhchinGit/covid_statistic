import 'dart:async';
import 'package:covid_statistic/repositories/token_api_client.dart';
import 'package:meta/meta.dart';

class TokenRepository {
  final TokenApiClient tokenApiClient;

  TokenRepository({@required this.tokenApiClient})
      : assert(tokenApiClient != null);

  Future<String> fetchToken(String username, String password) async =>
      await tokenApiClient.fetchToken(username, password);
}
