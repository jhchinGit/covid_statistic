import 'dart:async';
import 'package:meta/meta.dart';
import 'package:covid_statistic/repositories/report_api_client.dart';
import 'package:covid_statistic/models/models.dart';

class ReportRepository {
  final ReportApiClient reportApiClient;

  ReportRepository({@required this.reportApiClient})
      : assert(reportApiClient != null);

  Future<MyReport> fetchMalaysiaCovidReport() async =>
      await reportApiClient.fetchMalaysiaCovidReport();
}
