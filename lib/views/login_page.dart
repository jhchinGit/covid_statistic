import 'package:covid_statistic/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _authenticationCode = TextEditingController();
  var _usernameValidate = true;
  var _passwordValidate = true;
  var _authenticationCodeValidate = true;

  void onLogin(BuildContext context) {
    setState(() {
      _usernameValidate = _username.text.isEmpty == false;
      _passwordValidate = _password.text.isEmpty == false;
      _authenticationCodeValidate = _authenticationCode.text.isEmpty == false;
    });

    if (isAllValid()) {
      BlocProvider.of<LoginBloc>(context).add(FetchLogin(
          username: _username.text,
          password: _password.text,
          authenticationCode: _authenticationCode.text));
    }
  }

  bool isAllValid() {
    return _usernameValidate &&
        _passwordValidate &&
        _authenticationCodeValidate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, dynamic>(
        builder: (context, navigationState) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
        if (loginState is LoginLoading) {
          return Container(
            padding: EdgeInsets.only(top: 50),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (loginState is LoginLoaded) {
          BlocProvider.of<NavigatorBloc>(context)
              .add(NavigateToInternalReportEvent());
        }
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, left: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Welcome,",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      )),
                  Text(
                    "Sign in to continue!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: TextField(
                      controller: _username,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          errorText: !_usernameValidate
                              ? "Username cannot be empty!"
                              : null),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          errorText: !_passwordValidate
                              ? "Password cannot be empty!"
                              : null),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _authenticationCode,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Authentication code',
                            errorText: !_authenticationCodeValidate
                                ? "Authentication code cannot be empty!"
                                : null),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ButtonTheme(
                  child: ElevatedButton(
                    onPressed: () => onLogin(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey;
                          }
                          return Color.fromRGBO(
                              22, 199, 154, 1); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ))
          ],
        );
      });
    });
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _authenticationCode.dispose();
    super.dispose();
  }
}
