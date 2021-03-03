import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_statistic/models/models.dart';

abstract class InternalReportState extends Equatable {
  InternalReportState();

  @override
  List<Object> get props => [];
}

class InternalReportEmpty extends InternalReportState {}

class InternalReportLoading extends InternalReportState {}

class InternalReportLoaded extends InternalReportState {
  final InternalReport internalReport;

  InternalReportLoaded({@required this.internalReport})
      : assert(internalReport != null);

  @override
  List<Object> get props => [];
}

class InternalReportError extends InternalReportState {}
