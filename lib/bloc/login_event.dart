import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  final String username;
  final String password;
  final String authenticationCode;
  LoginEvent(
      {@required this.username,
      @required this.password,
      @required this.authenticationCode});
}

class FetchLogin extends LoginEvent {
  final String username;
  final String password;
  final String authenticationCode;
  FetchLogin(
      {@required this.username,
      @required this.password,
      @required this.authenticationCode});

  @override
  List<Object> get props => [];
}
