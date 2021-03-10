import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String accessToken;
  final int expiredInSeconds;
  final String tokenType;
  final String refreshToken;
  final String scope;
  final DateTime expireDate;

  Token(
      {this.accessToken,
      this.expiredInSeconds,
      this.tokenType,
      this.refreshToken,
      this.scope,
      this.expireDate});

  @override
  List<Object> get props => [
        accessToken,
        expiredInSeconds,
        tokenType,
        refreshToken,
        scope,
        expireDate
      ];

  static Token fromJson(dynamic json) {
    return Token(
        accessToken: json['access_token'],
        expiredInSeconds: json['expires_in'],
        tokenType: json['token_type'],
        refreshToken: json['refresh_token'],
        expireDate:
            DateTime.now().add(new Duration(seconds: json['expires_in'])),
        scope: json['scope']);
  }

  @override
  String toString() => 'Token {Access Token: $accessToken}';
}
