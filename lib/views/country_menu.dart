import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/widgets/country_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, dynamic>(builder: (context, state) {
      return Container(
        child: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.only(left: 5, right: 5),
          children: [
            CountryMenuButton(
                fileAndPathName: 'images/flag_my.png',
                name: "MALAYSIA",
                callback: () {
                  BlocProvider.of<NavigatorBloc>(context)
                      .add(NavigateToMalaysiaReportEvent());
                }),
            CountryMenuButton(
                fileAndPathName: 'images/flag_in.png',
                name: "INDIA",
                callback: () {
                  BlocProvider.of<NavigatorBloc>(context)
                      .add(NavigateToIndiaReportEvent());
                }),
          ],
        ),
      );
    });
  }
}
