import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({@required this.navigatorKey}) : assert(navigatorKey != null);

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorActionPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToMalaysiaReportEvent) {
      navigatorKey.currentState.pushNamed('/myReport');
    } else if (event is NavigateToIndiaReportEvent) {
      navigatorKey.currentState.pushNamed('/inReport');
    } else if (event is NavigateToMapEvent) {
      navigatorKey.currentState.pushNamed('/googleMap');
    } else if (event is NavigateToInternalReportEvent) {
      navigatorKey.currentState.pushNamed('/internalReport');
    }
  }
}
