import 'package:flutter/material.dart';

class StatisticAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  final PreferredSizeWidget bottom;

  StatisticAppBar({this.title, this.body, this.bottom}) : assert(body != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 236, 240, 1.0),
      appBar: AppBar(
        bottom: bottom,
        backgroundColor: Color.fromRGBO(22, 199, 154, 1),
        title: Text(
          title,
        ),
      ),
      body: body,
    );
  }
}
