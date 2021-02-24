import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class TokenApiClient {
  final _baseUrl = 'https://192.168.0.142:5001';
  final http.Client httpClient;

  TokenApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<String> fetchToken(String username, String password) async {
    Map<String, dynamic> body = {
      "grant_type": "password",
      "username": username,
      "password": password,
      "client_id": "muffin_owner_flow",
      "client_secret": "muffinsecret",
      "scope": "muffinscopeapi"
    };

    final url = '$_baseUrl/connect/token';
    final response = await this.httpClient.post(
      new Uri.https("192.168.0.142:5001", "/connect/token"),
      body: body,
      headers: {
        "Accept": "application.json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );

    if (response.statusCode != 200) {
      throw new Exception('error getting Malaysia report');
    }

    final json = jsonDecode(response.body);

    return "Succeed";
  }
}
