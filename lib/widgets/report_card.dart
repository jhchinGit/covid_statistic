import 'package:covid_statistic/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatefulWidget {
  final Color backgroundColor;
  final String title;
  final int caseCount;
  final int newCaseCount;
  final double newCaseRate;
  final IconData cardIcon;

  ReportCard({
    Key key,
    this.backgroundColor,
    this.title,
    this.caseCount,
    this.newCaseCount,
    this.newCaseRate,
    this.cardIcon,
  }) : super(key: key);

  _ReportCardState createState() => _ReportCardState(
        backgroundColor: this.backgroundColor,
        title: this.title,
        caseCount: this.caseCount,
        newCaseCount: this.newCaseCount,
        newCaseRate: this.newCaseRate,
        cardIcon: this.cardIcon,
      );
}

class _ReportCardState extends State<ReportCard>
    with SingleTickerProviderStateMixin {
  final Color backgroundColor;
  final String title;
  final int caseCount;
  final int newCaseCount;
  final double newCaseRate;
  final IconData cardIcon;

  _ReportCardState({
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
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
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
  Widget build(BuildContext context) => FadeTransition(
        opacity: animation,
        child: ReportCardContent(
            backgroundColor: this.backgroundColor,
            title: this.title,
            caseCount: this.caseCount,
            newCaseCount: this.newCaseCount,
            newCaseRate: this.newCaseRate,
            cardIcon: this.cardIcon),
      );
}

class ReportCardContent extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final int caseCount;
  final int newCaseCount;
  final double newCaseRate;
  final IconData cardIcon;

  ReportCardContent(
      {this.backgroundColor,
      this.title,
      this.caseCount,
      this.newCaseCount,
      this.newCaseRate,
      this.cardIcon});

  Widget build(BuildContext context) {
    var caseRateOperator = newCaseRate >= 0 ? "+" : "";

    return Container(
      height: 80,
      child: Card(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        clipBehavior: Clip.hardEdge,
        elevation: 6.0,
        child: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            openShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            openColor: backgroundColor,
            closedColor: backgroundColor,
            closedBuilder: (context, action) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: backgroundColor),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                cardIcon,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, top: 15),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 5),
                                      child: Text(
                                        NumberFormat('#,###,000')
                                            .format(caseCount),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    _newCasesRow(newCaseCount)
                                  ],
                                )
                              ],
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(
                                caseRateOperator +
                                    newCaseRate.toStringAsFixed(2) +
                                    '%',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            openBuilder: (context, action) {
              return Center(
                  child: ReportCardView(
                      backgroundColor: backgroundColor,
                      title: title,
                      caseCount: caseCount,
                      newCaseCount: newCaseCount,
                      newCaseRate: newCaseRate,
                      cardIcon: cardIcon));
            }),
      ),
    );
  }

  Row _newCasesRow(int cases) {
    if (cases == 0) {
      return Row();
    } else {
      var caseOperator = cases > 0 ? "+" : "";
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Text(
              caseOperator + NumberFormat('#,###').format(cases),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      );
    }
  }
}
