import 'package:covid_statistic/bloc/internal_report_event.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/models/models.dart';
import 'package:covid_statistic/bloc/bloc.dart';

class InternalReportBloc
    extends Bloc<InternalReportEvent, InternalReportState> {
  final ReportRepository repository;

  InternalReportBloc({@required this.repository}) : assert(repository != null);

  @override
  InternalReportState get initialState => InternalReportEmpty();

  @override
  Stream<InternalReportState> mapEventToState(
      InternalReportEvent event) async* {
    if (event is FetchInternalIndiaCovidReport) {
      yield InternalReportLoading();
      try {
        final InternalReport internalReport =
            await repository.fetchInternalCovidReport(Country.India.index);
        yield InternalReportLoaded(internalReport: internalReport);
      } catch (e) {
        yield InternalReportError(errorMessage: e["message"]);
      }
    } else if (event is FetchInternalMalaysiaCovidReport) {
      yield InternalReportLoading();
      try {
        final InternalReport internalReport =
            await repository.fetchInternalCovidReport(Country.Malaysia.index);
        yield InternalReportLoaded(internalReport: internalReport);
      } catch (e) {
        yield InternalReportError(errorMessage: e["message"]);
      }
    } else {
      yield InternalReportError(errorMessage: "Incorrect request!");
    }
  }
}
