import 'package:covid_statistic/views/country_menu.dart';
import 'package:covid_statistic/widgets/statistic_app_bar.dart';
import 'package:covid_statistic/views/malaysia_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/repositories/report_api_client.dart';
import 'package:covid_statistic/repositories/repositories.dart';

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
  final navigatorKey = GlobalKey<NavigatorState>();

  App({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/myReport': (context) => MalaysiaPage(
              repository: repository,
            ),
      },
      title: 'Covid Statistic App',
      theme: ThemeData(fontFamily: 'Comfortaa'),
      home: StatisticAppBar(
        title: "Covid-19 Status",
        body: BlocProvider(
          create: (context) =>
              NavigatorBloc(navigatorKey: navigatorKey, repository: repository),
          child: CountryMenu(),
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
