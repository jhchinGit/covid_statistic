import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final int caseCount;
  final int newCaseCount;
  final double newCaseRate;
  final IconData cardIcon;

  ReportCard(
      {this.backgroundColor,
      this.title,
      this.caseCount,
      this.newCaseCount,
      this.newCaseRate,
      this.cardIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Card(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
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
                                  padding: EdgeInsets.only(left: 20, top: 5),
                                  child: Text(
                                    NumberFormat('#,###,000').format(caseCount),
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
                            newCaseRate.toStringAsFixed(2) + '%',
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
          )),
    );
  }

  Row _newCasesRow(int cases) {
    if (cases == 0) {
      return Row();
    } else {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Text(
              "+" + NumberFormat('#,###').format(cases),
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
