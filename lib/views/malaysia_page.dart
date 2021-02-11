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
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 20),
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
              Container(
                height: 100,
                child: Card(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 25),
                                    child: Icon(
                                      Icons.alarm_on,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 15, top: 15),
                                        child: Text(
                                          "Total Cases: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 10),
                                            child: Text(
                                              NumberFormat('#,###,000').format(
                                                  state
                                                      .myReport.testedPositive),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          _newCasesRow(
                                              state.myReport.todayConfirmCases)
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          state.myReport.positiveRate
                                                  .toStringAsFixed(2) +
                                              '%',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Container(
                height: 400,
                child: Card(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Total Cases: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  NumberFormat('#,###,000')
                                      .format(state.myReport.testedPositive),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              _newCasesRow(state.myReport.todayConfirmCases),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Active Cases: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  NumberFormat('#,###,000')
                                      .format(state.myReport.activeCases),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              _newCasesRow(state.myReport.todayActiveCases)
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Deceased Cases: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  NumberFormat('#,###,000')
                                      .format(state.myReport.deceased),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              _newCasesRow(state.myReport.todayDeceasedCases)
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "Recovered Cases: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  NumberFormat('#,###,000')
                                      .format(state.myReport.recovered),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              _newCasesRow(state.myReport.todayRecovered),
                            ],
                          ),
                          Text(state.myReport.positiveRate.toStringAsFixed(2) +
                              '%'),
                          Text(state.myReport.activeRate.toStringAsFixed(2) +
                              '%'),
                          Text(state.myReport.deceaseRate.toStringAsFixed(2) +
                              '%'),
                          Text(state.myReport.recoveredRate.toStringAsFixed(2) +
                              '%')
                        ],
                      ),
                    )),
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Row _newCasesRow(int cases) {
    if (cases == 0) {
      return Row();
    } else {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, top: 10),
            child: Text(
              "+" + NumberFormat('#,###').format(cases),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.green),
            ),
          )
        ],
      );
    }
  }
}
