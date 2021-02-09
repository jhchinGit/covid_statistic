import 'package:equatable/equatable.dart';

class MyReport extends Equatable {
  final int testedPositive;
  final int recovered;
  final int activeCases;
  final int inICU;
  final int respiratoryAid;
  final int deceased;
  final DateTime lastUpdated;

  MyReport(
      {this.testedPositive,
      this.recovered,
      this.activeCases,
      this.inICU,
      this.respiratoryAid,
      this.deceased,
      this.lastUpdated});

  @override
  List<Object> get props => [
        testedPositive,
        recovered,
        activeCases,
        inICU,
        respiratoryAid,
        deceased,
        lastUpdated
      ];

  static MyReport fromJson(dynamic json) {
    return MyReport(
        testedPositive: json['testedPositive'],
        recovered: json['recovered'],
        activeCases: json['activeCases'],
        inICU: json['inICU'],
        respiratoryAid: json['respiratoryAid'],
        deceased: json['deceased'],
        lastUpdated: DateTime.parse(json['lastUpdatedAtApify'].toString()));
  }

  @override
  String toString() => 'Quote {id: $activeCases}';
}
