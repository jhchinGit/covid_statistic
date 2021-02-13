import 'package:flutter/material.dart';

class StatisticAppBar extends StatelessWidget {
  final String title;
  final Widget body;

  StatisticAppBar({this.title, this.body}) : assert(body != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 236, 240, 1.0),
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: body,
    );
  }
}
