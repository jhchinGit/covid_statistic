import 'package:equatable/equatable.dart';

abstract class InternalReportEvent extends Equatable {
  InternalReportEvent();
}

class FetchInternalMalaysiaCovidReport extends InternalReportEvent {
  FetchInternalMalaysiaCovidReport();

  @override
  List<Object> get props => [];
}

class FetchInternalIndiaCovidReport extends InternalReportEvent {
  FetchInternalIndiaCovidReport();

  @override
  List<Object> get props => [];
}
