import 'package:covid_statistic/views/India_page.dart';
import 'package:covid_statistic/views/country_list_menu.dart';
import 'package:covid_statistic/views/country_menu.dart';
import 'package:covid_statistic/views/input_control_page.dart';
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
          '/inReport': (context) => IndiaPage(
                repository: repository,
              ),
        },
        title: 'Covid Statistic App',
        theme: ThemeData(fontFamily: 'Comfortaa'),
        home: DefaultTabController(
          length: 3,
          child: StatisticAppBar(
            title: "Covid-19 Status",
            body: TabBarView(
              children: [
                BlocProvider(
                  create: (context) => NavigatorBloc(
                      navigatorKey: navigatorKey, repository: repository),
                  child: CountryMenu(),
                ),
                BlocProvider(
                  create: (context) => NavigatorBloc(
                      navigatorKey: navigatorKey, repository: repository),
                  child: CountryListMenu(),
                ),
                InputControlPage()
              ],
            ),
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(80, 80, 80, 1),
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_view),
                ),
                Tab(
                  icon: Icon(Icons.list_rounded),
                ),
                Tab(
                  icon: Icon(Icons.library_books_rounded),
                )
              ],
            ),
          ),
        ));
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
