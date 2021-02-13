import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_statistic/models/models.dart';

abstract class InReportState extends Equatable {
  InReportState();

  @override
  List<Object> get props => [];
}

class InReportEmpty extends InReportState {}

class InReportLoading extends InReportState {}

class InReportLoaded extends InReportState {
  final InReport inReport;

  InReportLoaded({@required this.inReport}) : assert(inReport != null);

  @override
  List<Object> get props => [inReport];
}

class InReportError extends InReportState {}
