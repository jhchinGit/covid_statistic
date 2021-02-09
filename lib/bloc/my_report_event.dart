import 'package:equatable/equatable.dart';

abstract class MyReportEvent extends Equatable {
  MyReportEvent();
}

class FetchMalaysiaCovidReport extends MyReportEvent {
  FetchMalaysiaCovidReport();

  @override
  List<Object> get props => [];
}
