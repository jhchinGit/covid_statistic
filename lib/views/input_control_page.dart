import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputControlPage extends StatefulWidget {
  @override
  _InputControlPageState createState() {
    return new _InputControlPageState();
  }
}

class _InputControlPageState extends State<InputControlPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  var _date = DateTime.now();
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
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  "Summary",
                  style: TextStyle(color: Colors.white),
                ),
                content: Container(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text("Username: " + _username.text,
                                style: TextStyle(color: Colors.white))),
                        Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text("Password: " + _password.text,
                                style: TextStyle(color: Colors.white))),
                        Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                                "Date: " +
                                    new DateFormat('dd MMM yyyy').format(_date),
                                style: TextStyle(color: Colors.white)))
                      ],
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
                elevation: 8,
                backgroundColor: Color.fromRGBO(22, 199, 154, 1),
              ),
          barrierDismissible: false);
    }
  }

  void onDatePick(BuildContext context) async {
    _date = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2090),
    );
  }

  bool isAllValid() {
    return _usernameValidate && _passwordValidate && _date != null;
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
          child: TextField(
            controller: _username,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                errorText:
                    !_usernameValidate ? "Username cannot be empty!" : null),
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
                    !_passwordValidate ? "Password cannot be empty!" : null),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () => onDatePick(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.5);
                  }
                  return Colors.green; // Use the component's default.
                },
              ),
            ),
            child: Icon(Icons.alarm),
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
                onPressed: () => onLogin(context),
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
  }
}
