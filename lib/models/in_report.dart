import 'package:equatable/equatable.dart';

class InReport extends Equatable {
  final int totalCase;
  final int newCase;
  final double newCaseRate;
  final int recovered;
  final int todayRecovered;
  final double recoveredRate;
  final int activeCase;
  final int todayActiveCase;
  final double activeRate;
  final int death;
  final int todayDeathCase;
  final double deathRate;
  final DateTime reportedDate;

  InReport(
      {this.totalCase,
      this.newCase,
      this.newCaseRate,
      this.recovered,
      this.todayRecovered,
      this.recoveredRate,
      this.activeCase,
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
        activeCase,
        todayActiveCase,
        activeRate,
        death,
        todayDeathCase,
        deathRate,
        reportedDate
      ];

  static InReport fromJson(dynamic json) {
    return InReport(
        totalCase: json['totalCases'],
        newCase:
            json['activeCasesNew'] + json['recoveredNew'] + json['deathsNew'],
        newCaseRate: _calculateRate(
            json['totalCases'],
            json['totalCases'] -
                json['activeCasesNew'] -
                json['recoveredNew'] -
                json['deathsNew']),
        recovered: json['recovered'],
        todayRecovered: json['recoveredNew'],
        recoveredRate: _calculateRate(
            json['recovered'], json['recovered'] - json['recoveredNew']),
        activeCase: json['activeCases'],
        todayActiveCase: json['activeCasesNew'],
        activeRate: _calculateRate(
            json['activeCases'], json['activeCases'] - json['activeCasesNew']),
        death: json['deaths'],
        todayDeathCase: json['deathsNew'],
        deathRate:
            _calculateRate(json['deaths'], json['deaths'] - json['deathsNew']),
        reportedDate: DateTime.parse(json['lastUpdatedAtApify'].toString()));
  }

  static double _calculateRate(int todayCount, int yesterdayCount) {
    if (yesterdayCount <= 0) {
      return todayCount.toDouble();
    }

    return ((todayCount / yesterdayCount) - 1) * 100;
  }

  @override
  String toString() => 'Quote {id: $activeCase}';
}
