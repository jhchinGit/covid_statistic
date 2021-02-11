import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/repositories/report_api_client.dart';
import 'package:covid_statistic/repositories/repositories.dart';
import 'package:covid_statistic/views/malaysia_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final ReportRepository repository = ReportRepository(
    reportApiClient: ReportApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(
    repository: repository,
  ));
}

class App extends StatelessWidget {
  final ReportRepository repository;

  App({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Statistic App',
      theme: ThemeData(fontFamily: 'Comfortaa'),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(246, 236, 240, 1.0),
        appBar: AppBar(
          title: Text(
            'Covid-19 Status',
            style: TextStyle(
                color: Color.fromRGBO(43, 65, 66, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocProvider(
          create: (context) => MyReportBloc(repository: repository),
          child: MalaysiaPage(),
        ),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
