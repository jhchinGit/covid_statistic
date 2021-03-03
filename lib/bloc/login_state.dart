import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final bool isLogin;

  LoginLoaded({@required this.isLogin}) : assert(isLogin != null);

  @override
  List<Object> get props => [isLogin];
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({@required this.errorMessage}) : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
