import 'dart:convert';
import 'dart:io';
import 'package:covid_statistic/utilities/token_helper.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:covid_statistic/models/models.dart';

class ReportApiClient {
  //final _baseUrl = 'https://api.apify.com/v2/key-value-stores';
  final _baseUrl = 'https://api.apify.com/v2';
  final http.Client httpClient;

  ReportApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<MyReport> fetchMalaysiaCovidReport() async {
    final url =
        '$_baseUrl/datasets/7Fdb90FMDLZir2ROo/items?format=json&clean=1';
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting Malaysia report');
    }

    final json = jsonDecode(response.body);

    return MyReport.fromJson(json);
  }

  Future<InReport> fetchIndiaCovidReport() async {
    final url =
        '$_baseUrl/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true';
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting India report');
    }

    final json = jsonDecode(response.body);

    return InReport.fromJson(json);
  }

  Future<InternalReport> fetchInternalCovidReport(int countryIndex) async {
    var tokenDto = await TokenHelper.getAccessTokenWithRefreshCheck(httpClient);

    if (!tokenDto.isSuccess) {
      throw new Exception('error getting token id');
    }

    final url =
        'http://192.168.50.207/ApiService/api/covid/' + countryIndex.toString();
    final response = await this.httpClient.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + tokenDto.accessToken
      },
    );

    if (response.statusCode != 200) {
      throw new Exception('error getting internal report');
    }

    final json = jsonDecode(response.body);

    return InternalReport.fromJson(json["data"]);
  }
}
