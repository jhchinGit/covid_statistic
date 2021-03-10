import 'package:covid_statistic/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
