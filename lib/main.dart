import 'package:covid_statistic/repositories/token_api_client.dart';
import 'package:covid_statistic/views/India_page.dart';
import 'package:covid_statistic/views/country_list_menu.dart';
import 'package:covid_statistic/views/country_menu.dart';
import 'package:covid_statistic/views/input_control_page.dart';
import 'package:covid_statistic/views/login_page.dart';
import 'package:covid_statistic/views/map_view.dart';
import 'package:covid_statistic/views/ride_hailing_page.dart';
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

  final ReportRepository reportRepository = ReportRepository(
    reportApiClient: ReportApiClient(
      httpClient: http.Client(),
    ),
  );

  final TokenRepository tokenRepository = TokenRepository(
    tokenApiClient: TokenApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(
      reportRepository: reportRepository, tokenRepository: tokenRepository));
}

class App extends StatelessWidget {
  final ReportRepository reportRepository;
  final TokenRepository tokenRepository;
  final navigatorKey = GlobalKey<NavigatorState>();

  App(
      {Key key,
      @required this.reportRepository,
      @required this.tokenRepository})
      : assert(reportRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/myReport': (context) => MalaysiaPage(
                repository: reportRepository,
              ),
          '/inReport': (context) => IndiaPage(
                repository: reportRepository,
              ),
          '/googleMap': (context) => MapView(),
        },
        title: 'Covid Statistic App',
        theme: ThemeData(fontFamily: 'Comfortaa'),
        home: DefaultTabController(
          length: 4,
          child: StatisticAppBar(
            title: "Covid-19 Status",
            body: TabBarView(
              children: [
                BlocProvider(
                  create: (context) => NavigatorBloc(
                      navigatorKey: navigatorKey, repository: reportRepository),
                  child: CountryMenu(),
                ),
                BlocProvider(
                  create: (context) => NavigatorBloc(
                      navigatorKey: navigatorKey, repository: reportRepository),
                  child: CountryListMenu(),
                ),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => NavigatorBloc(
                          navigatorKey: navigatorKey,
                          repository: reportRepository),
                    ),
                    BlocProvider(
                      create: (context) =>
                          LoginBloc(repository: tokenRepository),
                    ),
                  ],
                  child: LoginPage(),
                ),
                BlocProvider(
                  create: (context) => NavigatorBloc(
                      navigatorKey: navigatorKey, repository: reportRepository),
                  child: RideHailingPage(),
                ),
              ],
            ),
            bottom: TabBar(
              isScrollable: true,
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
                ),
                Tab(
                  icon: Icon(Icons.map_rounded),
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
