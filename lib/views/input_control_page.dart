import 'package:flutter/material.dart';

class InputControlPage extends StatefulWidget {
  @override
  _InputControlPageState createState() {
    return new _InputControlPageState();
  }
}

class _InputControlPageState extends State<InputControlPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _usernameValidate = false;
  bool _passwordValidate = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
            child: TextField(
              controller: _username,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  errorText:
                      _usernameValidate ? "Username cannot be empty!" : null),
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
                  errorText:
                      _passwordValidate ? "Password cannot be empty!" : null),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () => {
                setState(() {
                  _username.text.isEmpty
                      ? _usernameValidate = true
                      : _usernameValidate = false;
                  _password.text.isEmpty
                      ? _passwordValidate = true
                      : _passwordValidate = false;
                })
              },
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
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}
