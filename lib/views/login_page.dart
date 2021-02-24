import 'package:covid_statistic/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  var _usernameValidate = true;
  var _passwordValidate = true;

  void onLogin(BuildContext context, LoginState loginState) {
    setState(() {
      _username.text.isEmpty
          ? _usernameValidate = false
          : _usernameValidate = true;
      _password.text.isEmpty
          ? _passwordValidate = false
          : _passwordValidate = true;
    });

    if (isAllValid()) {
      BlocProvider.of<LoginBloc>(context)
          .add(FetchLogin(username: _username.text, password: _password.text));

      if (loginState is LoginLoaded) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Well Done!"),
                  content: Text("Successfully login!"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"))
                  ],
                ),
            barrierDismissible: false);
      } else if (loginState is LoginError) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Fail to login"),
                  content: Text(loginState.errorMessage),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"))
                  ],
                ),
            barrierDismissible: false);
      }
    }
  }

  bool isAllValid() {
    return _usernameValidate && _passwordValidate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, dynamic>(
        builder: (context, navigationState) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
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
              padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
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
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: () => onLogin(context, loginState),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          }
                          return Colors.black; // Use the component's default.
                        },
                      ),
                    ),
                    child: Text("Login"),
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
    super.dispose();
  }
}
