import 'package:equatable/equatable.dart';

enum Country { Malaysia, India }

class InternalReport extends Equatable {
  final int totalCase;
  final int newCase;
  final double newCaseRate;
  final int recovered;
  final int recoveredNew;
  final double recoveredRate;
  final int activeCase;
  final int todayActiveCase;
  final double activeRate;
  final int death;
  final int todayDeathCase;
  final double deathRate;
  final DateTime reportedDate;

  InternalReport(
      {this.totalCase,
      this.newCase,
      this.newCaseRate,
      this.recovered,
      this.recoveredNew,
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
        recoveredNew,
        recoveredRate,
        activeCase,
        todayActiveCase,
        activeRate,
        death,
        todayDeathCase,
        deathRate,
        reportedDate
      ];

  static InternalReport fromJson(dynamic json) {
    return InternalReport(
        totalCase: json['totalCase'],
        newCase: json['newCase'],
        newCaseRate: json['newCaseRate'],
        recovered: json['recovered'],
        recoveredNew: json['recoveredNew'],
        recoveredRate: json['recoveredRate'],
        activeCase: json['activeCase'],
        todayActiveCase: json['todayActiveCase'],
        activeRate: json['activeRate'],
        death: json['death'],
        todayDeathCase: json['todayDeathCase'],
        deathRate: json['deathRate'],
        reportedDate: DateTime.parse(json['reportedDateStr']));
  }

  @override
  String toString() => 'Active Case $activeCase';
}
