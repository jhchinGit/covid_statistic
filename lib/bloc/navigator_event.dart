import 'package:equatable/equatable.dart';

abstract class NavigatorEvent extends Equatable {
  NavigatorEvent();
}

class NavigateToMalaysiaReportEvent extends NavigatorEvent {
  NavigateToMalaysiaReportEvent();

  @override
  List<Object> get props => [];
}

class NavigateToIndiaReportEvent extends NavigatorEvent {
  NavigateToIndiaReportEvent();

  @override
  List<Object> get props => [];
}

class NavigatorActionPop extends NavigatorEvent {
  NavigatorActionPop();

  @override
  List<Object> get props => [];
}

class NavigateToMapEvent extends NavigatorEvent {
  NavigateToMapEvent();

  @override
  List<Object> get props => [];
}
