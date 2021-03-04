import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternalCountryMenu extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  InternalCountryMenu({Key key, @required this.navigatorKey})
      : assert(navigatorKey != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatisticAppBar(
      title: "Internal Report Menu",
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => NavigatorBloc(navigatorKey: navigatorKey),
          child: BlocBuilder<NavigatorBloc, dynamic>(builder: (context, state) {
            return Row(
              children: [
                CountryMenuButton(
                    fileAndPathName: 'images/flag_my.png',
                    name: "MALAYSIA",
                    callback: () {
                      BlocProvider.of<NavigatorBloc>(context)
                          .add(NavigateToInternalMalaysiaReportEvent());
                    }),
                CountryMenuButton(
                    fileAndPathName: 'images/flag_in.png',
                    name: "INDIA",
                    callback: () {
                      BlocProvider.of<NavigatorBloc>(context)
                          .add(NavigateToInternalIndiaReportEvent());
                    })
              ],
            );
          }),
        ),
      ),
    );
  }
}
