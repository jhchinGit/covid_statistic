import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MyReport extends Equatable {
  final int testedPositive;
  final int todayConfirmCases;
  final double positiveRate;
  final int recovered;
  final int todayRecovered;
  final double recoveredRate;
  final int activeCases;
  final int todayActiveCases;
  final double activeRate;
  final int inICU;
  final int respiratoryAid;
  final int deceased;
  final int todayDeceasedCases;
  final double deceaseRate;
  final DateTime lastUpdated;

  MyReport(
      {this.testedPositive,
      this.todayConfirmCases,
      this.positiveRate,
      this.recovered,
      this.todayRecovered,
      this.recoveredRate,
      this.activeCases,
      this.todayActiveCases,
      this.activeRate,
      this.inICU,
      this.respiratoryAid,
      this.deceased,
      this.todayDeceasedCases,
      this.deceaseRate,
      this.lastUpdated});

  @override
  List<Object> get props => [
        testedPositive,
        todayConfirmCases,
        positiveRate,
        recovered,
        todayRecovered,
        recoveredRate,
        activeCases,
        todayActiveCases,
        activeRate,
        inICU,
        respiratoryAid,
        deceased,
        todayDeceasedCases,
        deceaseRate,
        lastUpdated
      ];

  static MyReport fromJson(dynamic json) {
    int jsonCount = json.toList().length;
    var todayJson = json[jsonCount - 1];
    var lastUpdate =
        DateTime.parse(todayJson['lastUpdatedAtSource'].toString());
    var yesterdayJson = json[_getYesterdayJsonIndex(
        int.parse(DateFormat('d').format(lastUpdate)), json)];

    return MyReport(
        testedPositive: todayJson['testedPositive'],
        todayConfirmCases:
            todayJson['testedPositive'] - yesterdayJson['testedPositive'],
        positiveRate: _calculateRate(
            todayJson['testedPositive'], yesterdayJson['testedPositive']),
        recovered: todayJson['recovered'],
        todayRecovered: todayJson['recovered'] - yesterdayJson['recovered'],
        recoveredRate:
            _calculateRate(todayJson['recovered'], yesterdayJson['recovered']),
        activeCases: todayJson['activeCases'],
        todayActiveCases:
            todayJson['activeCases'] - yesterdayJson['activeCases'],
        activeRate: _calculateRate(
            todayJson['activeCases'], yesterdayJson['activeCases']),
        inICU: todayJson['inICU'],
        respiratoryAid: todayJson['respiratoryAid'],
        deceased: todayJson['deceased'],
        todayDeceasedCases: todayJson['deceased'] - yesterdayJson['deceased'],
        deceaseRate:
            _calculateRate(todayJson['deceased'], yesterdayJson['deceased']),
        lastUpdated: lastUpdate);
  }

  static int _getYesterdayJsonIndex(int dayOfToday, dynamic reportList) {
    if (reportList.length == 0) {
      return -1;
    }

    var index = reportList.length - 2;
    var yesterdayJsonIndex = -1;

    while (yesterdayJsonIndex == -1) {
      var yesterday = int.parse(DateFormat('d').format(
          DateTime.parse(reportList[index]['lastUpdatedAtSource'].toString())));

      if (yesterday != dayOfToday) {
        yesterdayJsonIndex = index;
      }
      index--;
    }

    return yesterdayJsonIndex;
  }

  static double _calculateRate(int todayCount, int yesterdayCount) {
    if (yesterdayCount <= 0) {
      return todayCount.toDouble();
    }

    return ((todayCount / yesterdayCount) - 1) * 100;
  }

  @override
  String toString() => 'Quote {id: $activeCases}';
}
