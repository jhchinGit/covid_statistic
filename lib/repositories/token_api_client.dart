import 'dart:convert';

import 'package:covid_statistic/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class TokenApiClient {
  final http.Client httpClient;

  TokenApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Token> fetchToken(String username, String password) async {
    Map<String, dynamic> body = {
      "grant_type": "password",
      "username": username,
      "password": password,
      "client_id": "muffin_owner_flow",
      "client_secret": "muffinsecret",
      "scope": "muffinscopeapi"
    };

    final response = await this.httpClient.post(
      Uri.http('192.168.0.142', 'identityServer/connect/token'),
      body: body,
      headers: {
        "Accept": "application.json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );

    if (response.statusCode != 200) {
      throw new Exception('error getting token');
    }

    final json = jsonDecode(response.body);

    return Token.fromJson(json);
  }
}
