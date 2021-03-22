import 'dart:convert';
import 'dart:io';

import 'package:covid_statistic/utilities/token_helper.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class LoginApiClient {
  final http.Client httpClient;

  LoginApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<bool> fetchLogin(String username, String authenticationCode) async {
    var tokenDto = await TokenHelper.getAccessTokenWithRefreshCheck(httpClient);

    if (!tokenDto.isSuccess) {
      throw new Exception('error getting token id');
    }

    final response = await this.httpClient.post(
      Uri.http('192.168.0.182', 'ApiService/api/authenticationCode/'),
      body: jsonEncode(<String, String>{
        "Username": username,
        "AuthenticationCode": authenticationCode,
      }),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + tokenDto.accessToken
      },
    );

    if (response.statusCode != 200) {
      throw new Exception('error getting token');
    } else {
      return true;
    }
  }
}
