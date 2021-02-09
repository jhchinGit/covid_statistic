import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_statistic/models/models.dart';

abstract class MyReportState extends Equatable {
  MyReportState();

  @override
  List<Object> get props => [];
}

class MyReportEmpty extends MyReportState {}

class MyReportLoading extends MyReportState {}

class MyReportLoaded extends MyReportState {
  final MyReport myReport;

  MyReportLoaded({@required this.myReport}) : assert(myReport != null);

  @override
  List<Object> get props => [myReport];
}

class MyReportError extends MyReportState {}
