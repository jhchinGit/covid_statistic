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
          return Center(
              child: Card(
            child: Column(
              children: [
                Image.asset(
                  'images/flag_my.png',
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
