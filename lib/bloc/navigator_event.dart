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

class NavigateToInternalReportEvent extends NavigatorEvent {
  NavigateToInternalReportEvent();

  @override
  List<Object> get props => [];
}

class NavigateToInternalMalaysiaReportEvent extends NavigatorEvent {
  NavigateToInternalMalaysiaReportEvent();

  @override
  List<Object> get props => [];
}

class NavigateToInternalIndiaReportEvent extends NavigatorEvent {
  NavigateToInternalIndiaReportEvent();

  @override
  List<Object> get props => [];
}
