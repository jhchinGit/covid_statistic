import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String accessToken;
  final int expiredInSeconds;
  final String tokenType;
  final String scope;

  Token({this.accessToken, this.expiredInSeconds, this.tokenType, this.scope});

  @override
  List<Object> get props => [
        accessToken,
        expiredInSeconds,
        tokenType,
        scope,
      ];

  static Token fromJson(dynamic json) {
    return Token(
        accessToken: json['access_token'],
        expiredInSeconds: json['expires_in'],
        tokenType: json['token_type'],
        scope: json['scope']);
  }

  @override
  String toString() => 'Token {Access Token: $accessToken}';
}
