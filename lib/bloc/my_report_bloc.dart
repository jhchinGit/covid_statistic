import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/models/models.dart';
import 'package:covid_statistic/bloc/bloc.dart';

class MyReportBloc extends Bloc<MyReportEvent, MyReportState> {
  final ReportRepository repository;

  MyReportBloc({@required this.repository}) : assert(repository != null);

  @override
  MyReportState get initialState => MyReportEmpty();

  @override
  Stream<MyReportState> mapEventToState(MyReportEvent event) async* {
    if (event is FetchMalaysiaCovidReport) {
      yield MyReportLoading();
      try {
        final MyReport myReport = await repository.fetchMalaysiaCovidReport();
        yield MyReportLoaded(myReport: myReport);
      } catch (_) {
        yield MyReportError();
      }
    }
  }
}
