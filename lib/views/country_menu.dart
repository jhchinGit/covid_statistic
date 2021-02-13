import 'package:covid_statistic/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, dynamic>(builder: (context, state) {
      return Center(
        child: ElevatedButton(
            child: Text('Hello'),
            onPressed: () {
              BlocProvider.of<NavigatorBloc>(context)
                  .add(NavigateToMalaysiaReportEvent());
            }),
      );
    });
  }
}
