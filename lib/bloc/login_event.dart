import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  final String username;
  final String password;
  LoginEvent({@required this.username, @required this.password});
}

class FetchLogin extends LoginEvent {
  final String username;
  final String password;
  FetchLogin({@required this.username, @required this.password});

  @override
  List<Object> get props => [];
}
