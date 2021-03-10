import 'package:covid_statistic/models/models.dart';
import 'package:covid_statistic/repositories/token_api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TokenHelper {
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<bool> saveToken(Token accessToken) async {
    try {
      await _secureStorage.write(
          key: StorageKey.tokenKey.toString(), value: accessToken.accessToken);

      await _secureStorage.write(
          key: StorageKey.refreshToken.toString(),
          value: accessToken.refreshToken);

      await _secureStorage.write(
          key: StorageKey.tokenExpireDate.toString(),
          value: accessToken.expireDate.toString());
    } catch (_) {
      return false;
    }

    return true;
  }

  static Future<String> getAccessToken() async {
    return await _secureStorage.read(key: StorageKey.tokenKey.toString());
  }

  static Future<TokenDto> getAccessTokenWithRefreshCheck(
      http.Client httpClient) async {
    var result = new TokenDto();
    result.isSuccess = false;
    if (httpClient == null) {
      return result;
    }
    var expireDateStr =
        await _secureStorage.read(key: StorageKey.tokenExpireDate.toString());
    if (expireDateStr.isEmpty) {
      return result;
    }

    var expireDate = DateTime.parse(expireDateStr);

    if (expireDate.isAfter(DateTime.now())) {
      result.accessToken =
          await _secureStorage.read(key: StorageKey.tokenKey.toString());

      if (result.accessToken.isNotEmpty) {
        result.isSuccess = true;
      }
    } else {
      var tokenApiClient = new TokenApiClient(httpClient: httpClient);
      Token token;
      try {
        var refreshToken =
            await _secureStorage.read(key: StorageKey.refreshToken.toString());

        if (refreshToken.isNotEmpty) {
          token = await tokenApiClient.refreshToken(refreshToken);
        }
      } catch (_) {}

      if (token != null && await TokenHelper.saveToken(token)) {
        result.accessToken = token.accessToken;
        result.isSuccess = true;
      }
    }

    return result;
  }
}
