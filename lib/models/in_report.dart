import 'package:equatable/equatable.dart';

class InReport extends Equatable {
  final int totalCases;
  final int newCases;
  final double newCaseRate;
  final int recovered;
  final int todayRecovered;
  final double recoveredRate;
  final int activeCases;
  final int todayActiveCases;
  final double activeRate;
  final int death;
  final int todayDeathCases;
  final double deathRate;
  final DateTime lastUpdated;

  InReport(
      {this.totalCases,
      this.newCases,
      this.newCaseRate,
      this.recovered,
      this.todayRecovered,
      this.recoveredRate,
      this.activeCases,
      this.todayActiveCases,
      this.activeRate,
      this.death,
      this.todayDeathCases,
      this.deathRate,
      this.lastUpdated});

  @override
  List<Object> get props => [
        totalCases,
        newCases,
        newCaseRate,
        recovered,
        todayRecovered,
        recoveredRate,
        activeCases,
        todayActiveCases,
        activeRate,
        death,
        todayDeathCases,
        deathRate,
        lastUpdated
      ];

  static InReport fromJson(dynamic json) {
    return InReport(
        totalCases: json['totalCases'],
        newCases:
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
        activeCases: json['activeCases'],
        todayActiveCases: json['activeCasesNew'],
        activeRate: _calculateRate(
            json['activeCases'], json['activeCases'] - json['activeCasesNew']),
        death: json['deaths'],
        todayDeathCases: json['deathsNew'],
        deathRate:
            _calculateRate(json['deaths'], json['deaths'] - json['deathsNew']),
        lastUpdated: DateTime.parse(json['lastUpdatedAtApify'].toString()));
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
