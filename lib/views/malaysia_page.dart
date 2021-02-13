import 'package:covid_statistic/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/widgets/widgets.dart';
import 'package:intl/intl.dart';

import '../widgets/statistic_app_bar.dart';

class MalaysiaPage extends StatelessWidget {
  final ReportRepository repository;

  MalaysiaPage({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  static Route route(ReportRepository repository) {
    return MaterialPageRoute<void>(
        builder: (_) => MalaysiaPage(
              repository: repository,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return StatisticAppBar(
      title: "Malaysia Status",
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => MyReportBloc(repository: repository),
          child: BlocBuilder<MyReportBloc, MyReportState>(
            builder: (context, state) {
              if (state is MyReportEmpty) {
                BlocProvider.of<MyReportBloc>(context)
                    .add(FetchMalaysiaCovidReport());
              }
              if (state is MyReportError) {
                return Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: Text('failed to fetch Malaysia covid report')),
                );
              }
              if (state is MyReportLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            padding:
                                EdgeInsets.only(left: 20, top: 20, bottom: 20),
                            child: RoundImage(
                              fileAndPathName: 'images/flag_my.png',
                              width: 40,
                              height: 40,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10, top: 20),
                                child: Text(
                                  "Malaysia",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 5, bottom: 20),
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
                      cardIcon: Icons.healing,
                    ),
                  ],
                );
              }

              return Container(
                padding: EdgeInsets.only(top: 50),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
