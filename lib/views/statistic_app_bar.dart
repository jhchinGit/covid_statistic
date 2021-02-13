import 'package:flutter/material.dart';

class StatisticAppBar extends StatelessWidget {
  final Widget body;

  StatisticAppBar({this.body}) : assert(body != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 236, 240, 1.0),
      appBar: AppBar(
        title: Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      body: body,
    );
  }
}
