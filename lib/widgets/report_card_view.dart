import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportCardView extends StatefulWidget {
  final Color backgroundColor;
  final String title;
  final int caseCount;
  final int newCaseCount;
  final double newCaseRate;
  final IconData cardIcon;

  ReportCardView(
      {this.backgroundColor,
      this.title,
      this.caseCount,
      this.newCaseCount,
      this.newCaseRate,
      this.cardIcon});

  _ReportCardView createState() => _ReportCardView(
        backgroundColor: this.backgroundColor,
        title: this.title,
        caseCount: this.caseCount,
        newCaseCount: this.newCaseCount,
        newCaseRate: this.newCaseRate,
        cardIcon: this.cardIcon,
      );
}

class _ReportCardView extends State<ReportCardView>
    with SingleTickerProviderStateMixin {
  final Color backgroundColor;
  final String title;
  final int caseCount;
  final int newCaseCount;
  final double newCaseRate;
  final IconData cardIcon;

  _ReportCardView({
    this.backgroundColor,
    this.title,
    this.caseCount,
    this.newCaseCount,
    this.newCaseRate,
    this.cardIcon,
  });

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuart));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var caseRateOperator = newCaseRate >= 0 ? "+" : "";

    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      axisAlignment: -1,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                cardIcon,
                color: Colors.black,
                size: 100,
              ),
            ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                NumberFormat('#,###,000').format(caseCount),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 50,
                ),
              ),
            ),
            _newCasesContainer(newCaseCount),
            Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  caseRateOperator + newCaseRate.toStringAsFixed(2) + '%',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ))
          ]),
    );
  }

  Container _newCasesContainer(int cases) {
    if (cases == 0) {
      return Container();
    } else {
      var caseOperator = cases > 0 ? "+" : "";
      return Container(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          caseOperator + NumberFormat('#,###').format(cases),
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      );
    }
  }
}
