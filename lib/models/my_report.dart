import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MyReport extends Equatable {
  final int totalCase;
  final int newCase;
  final double newCaseRate;
  final int recovered;
  final int todayRecovered;
  final double recoveredRate;
  final int activeCases;
  final int todayActiveCase;
  final double activeRate;
  final int death;
  final int todayDeathCase;
  final double deathRate;
  final DateTime reportedDate;

  MyReport(
      {this.totalCase,
      this.newCase,
      this.newCaseRate,
      this.recovered,
      this.todayRecovered,
      this.recoveredRate,
      this.activeCases,
      this.todayActiveCase,
      this.activeRate,
      this.death,
      this.todayDeathCase,
      this.deathRate,
      this.reportedDate});

  @override
  List<Object> get props => [
        totalCase,
        newCase,
        newCaseRate,
        recovered,
        todayRecovered,
        recoveredRate,
        activeCases,
        todayActiveCase,
        activeRate,
        death,
        todayDeathCase,
        deathRate,
        reportedDate
      ];

  static MyReport fromJson(dynamic json) {
    int jsonCount = json.toList().length;
    var todayJson = json[jsonCount - 1];
    var lastUpdate =
        DateTime.parse(todayJson['lastUpdatedAtSource'].toString());
    var yesterdayJson = json[_getYesterdayJsonIndex(
        int.parse(DateFormat('d').format(lastUpdate)), json)];

    return MyReport(
        totalCase: todayJson['testedPositive'],
        newCase: todayJson['testedPositive'] - yesterdayJson['testedPositive'],
        newCaseRate: _calculateRate(
            todayJson['testedPositive'], yesterdayJson['testedPositive']),
        recovered: todayJson['recovered'],
        todayRecovered: todayJson['recovered'] - yesterdayJson['recovered'],
        recoveredRate:
            _calculateRate(todayJson['recovered'], yesterdayJson['recovered']),
        activeCases: todayJson['activeCases'],
        todayActiveCase:
            todayJson['activeCases'] - yesterdayJson['activeCases'],
        activeRate: _calculateRate(
            todayJson['activeCases'], yesterdayJson['activeCases']),
        death: todayJson['deceased'],
        todayDeathCase: todayJson['deceased'] - yesterdayJson['deceased'],
        deathRate:
            _calculateRate(todayJson['deceased'], yesterdayJson['deceased']),
        reportedDate: lastUpdate.add(Duration(hours: 4)));
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
