import 'package:covid_statistic/bloc/bloc.dart';
import 'package:flutter/material.dart';
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
  var _usernameValidate = true;
  var _passwordValidate = true;

  void onLogin(BuildContext context) {
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
    }
  }

  // void showLoginState(BuildContext context, LoginState loginState) {
  //   if (loginState is LoginLoaded) {
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               title: Text("Well Done!"),
  //               content: Text("Successfully login!"),
  //               actions: [
  //                 FlatButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text("OK"))
  //               ],
  //             ),
  //         barrierDismissible: false);
  //   } else if (loginState is LoginError) {
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               title: Text("Fail to login"),
  //               content: Text(loginState.errorMessage),
  //               actions: [
  //                 FlatButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text("OK"))
  //               ],
  //             ),
  //         barrierDismissible: false);
  //   }
  // }

  bool isAllValid() {
    return _usernameValidate && _passwordValidate;
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
              height: 230,
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
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 70,
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
    super.dispose();
  }
}
