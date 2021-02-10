import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_statistic/bloc/bloc.dart';
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
          return Container(
            height: 300,
            child: Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10),
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
                              padding: EdgeInsets.only(left: 10, top: 5),
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
                                new DateFormat('dd/MMM/yyyy hh:mm')
                                    .format(state.myReport.lastUpdated),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(133, 126, 129, 1)),
                              ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Last Update: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(167, 197, 235, 1)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
