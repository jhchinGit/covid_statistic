import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, dynamic>(builder: (context, state) {
      return ListView(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
        children: [
          CountryListMenuButton(
              fileAndPathName: 'images/flag_my.png',
              name: "MALAYSIA",
              subtitle: "Gets from http://covid-19.moh.gov.my/",
              callback: () {
                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigateToMalaysiaReportEvent());
              }),
          CountryListMenuButton(
              fileAndPathName: 'images/flag_in.png',
              name: "INDIA",
              subtitle: "Gets fromhttps://www.mohfw.gov.in/",
              callback: () {
                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigateToIndiaReportEvent());
              }),
        ],
      );
    });
  }
}
