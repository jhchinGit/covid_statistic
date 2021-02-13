import 'package:equatable/equatable.dart';

abstract class InReportEvent extends Equatable {
  InReportEvent();
}

class FetchIndiaCovidReport extends InReportEvent {
  FetchIndiaCovidReport();

  @override
  List<Object> get props => [];
}
