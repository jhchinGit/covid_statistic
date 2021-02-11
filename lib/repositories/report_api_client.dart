import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:covid_statistic/models/models.dart';

class ReportApiClient {
  //final _baseUrl = 'https://api.apify.com/v2/key-value-stores';
  final _baseUrl = 'https://api.apify.com/v2/datasets';
  final http.Client httpClient;

  ReportApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<MyReport> fetchMalaysiaCovidReport() async {
    final url = '$_baseUrl/7Fdb90FMDLZir2ROo/items?format=json&clean=1';
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting Malaysia report');
    }

    final json = jsonDecode(response.body);

    return MyReport.fromJson(json);
  }
}
