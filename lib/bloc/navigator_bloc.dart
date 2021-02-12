import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/views/country_menu.dart';
import 'package:covid_statistic/views/malaysia_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;
  final ReportRepository repository;

  NavigatorBloc({this.navigatorKey, @required this.repository})
      : assert(repository != null);

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorActionPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToMalaysiaReportEvent) {
      navigatorKey.currentState.pushNamed('/myReport');
    }
  }
}
