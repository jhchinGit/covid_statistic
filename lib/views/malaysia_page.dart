import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/widgets/widgets.dart';
import 'package:intl/intl.dart';

class MalaysiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyReportBloc, MyReportState>(
      builder: (context, state) {
        if (state is MyReportEmpty) {
          BlocProvider.of<MyReportBloc>(context)
              .add(FetchMalaysiaCovidReport());
        }
        if (state is MyReportError) {
          return Center(
            child: Text('failed to fetch Malaysia covid report'),
          );
        }
        if (state is MyReportLoaded) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset('images/flag_my.png',
                            width: 40, height: 40, fit: BoxFit.fill)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Malaysia",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            new DateFormat('h:mm a - dd MMM yyyy')
                                .format(state.myReport.lastUpdated),
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(133, 126, 129, 1)),
                          ))
                    ],
                  )
                ],
              ),
              ReportCard(
                backgroundColor: Color.fromRGBO(153, 225, 229, 1),
                title: "Total Cases",
                caseCount: state.myReport.testedPositive,
                newCaseCount: state.myReport.todayConfirmCases,
                newCaseRate: state.myReport.positiveRate,
                cardIcon: Icons.alarm_on,
              ),
              ReportCard(
                backgroundColor: Color.fromRGBO(243, 232, 203, 1),
                title: "Active Cases",
                caseCount: state.myReport.activeCases,
                newCaseCount: state.myReport.todayActiveCases,
                newCaseRate: state.myReport.activeRate,
                cardIcon: Icons.online_prediction,
              ),
              ReportCard(
                backgroundColor: Color.fromRGBO(251, 175, 175, 1),
                title: "Deceased",
                caseCount: state.myReport.deceased,
                newCaseCount: state.myReport.todayDeceasedCases,
                newCaseRate: state.myReport.deceaseRate,
                cardIcon: Icons.airline_seat_flat,
              ),
              ReportCard(
                  backgroundColor: Color.fromRGBO(153, 229, 156, 1),
                  title: "Recovered Cases",
                  caseCount: state.myReport.recovered,
                  newCaseCount: state.myReport.todayRecovered,
                  newCaseRate: state.myReport.recoveredRate,
                  cardIcon: Icons.healing),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
