import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/models/models.dart';
import 'package:covid_statistic/bloc/bloc.dart';

class InReportBloc extends Bloc<InReportEvent, InReportState> {
  final ReportRepository repository;

  InReportBloc({@required this.repository}) : assert(repository != null);

  @override
  InReportState get initialState => InReportEmpty();

  @override
  Stream<InReportState> mapEventToState(InReportEvent event) async* {
    if (event is FetchIndiaCovidReport) {
      yield InReportLoading();
      try {
        final InReport inReport = await repository.fetchIndiaCovidReport();
        yield InReportLoaded(inReport: inReport);
      } catch (_) {
        yield InReportError();
      }
    }
  }
}
