// import 'package:covid_statistic/repositories/repositories.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:covid_statistic/bloc/bloc.dart';
// import 'package:covid_statistic/widgets/widgets.dart';
// import 'package:intl/intl.dart';

// class InternalPage extends StatelessWidget {
//   final ReportRepository repository;

//   InternalPage({Key key, @required this.repository})
//       : assert(repository != null),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StatisticAppBar(
//       title: "Internal Status",
//       body: SingleChildScrollView(
//         child: BlocProvider(
//           create: (context) => InReportBloc(repository: repository),
//           child: BlocBuilder<InReportBloc, InReportState>(
//             builder: (context, state) {
//               if (state is InternalReportEmpty) {
//                 BlocProvider.of<InternalReportBloc>(context)
//                     .add(FetchInternalIndiaCovidReport());
//               }
//               if (state is InternalReportError) {
//                 return Container(
//                   padding: EdgeInsets.only(top: 50),
//                   child: Center(
//                       child: Text('failed to fetch Internal covid report')),
//                 );
//               }
//               if (state is InternalReportLoaded) {
//                 return Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                             padding:
//                                 EdgeInsets.only(left: 20, top: 20, bottom: 20),
//                             child: RoundImage(
//                               fileAndPathName: 'images/flag_in.png',
//                               width: 40,
//                               height: 40,
//                               semanticLabel: "Internal Flag",
//                             )),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 padding: EdgeInsets.only(left: 10, top: 20),
//                                 child: Text(
//                                   "Internal",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 )),
//                             Container(
//                                 padding: EdgeInsets.only(
//                                     left: 10, top: 5, bottom: 20),
//                                 child: Text(
//                                   new DateFormat('h:mm a - dd MMM yyyy')
//                                       .format(state.inReport.reportedDate),
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Color.fromRGBO(133, 126, 129, 1)),
//                                 ))
//                           ],
//                         )
//                       ],
//                     ),
//                     ReportCard(
//                       backgroundColor: Color.fromRGBO(153, 225, 229, 1),
//                       title: "Total Cases",
//                       caseCount: state.inReport.totalCase,
//                       newCaseCount: state.inReport.newCase,
//                       newCaseRate: state.inReport.newCaseRate,
//                       cardIcon: Icons.alarm_on,
//                     ),
//                     ReportCard(
//                       backgroundColor: Color.fromRGBO(243, 232, 203, 1),
//                       title: "Active Cases",
//                       caseCount: state.inReport.activeCase,
//                       newCaseCount: state.inReport.todayActiveCase,
//                       newCaseRate: state.inReport.activeRate,
//                       cardIcon: Icons.online_prediction,
//                     ),
//                     ReportCard(
//                       backgroundColor: Color.fromRGBO(251, 175, 175, 1),
//                       title: "Deceased",
//                       caseCount: state.inReport.death,
//                       newCaseCount: state.inReport.todayDeathCase,
//                       newCaseRate: state.inReport.deathRate,
//                       cardIcon: Icons.airline_seat_flat,
//                     ),
//                     ReportCard(
//                       backgroundColor: Color.fromRGBO(153, 229, 156, 1),
//                       title: "Recovered Cases",
//                       caseCount: state.inReport.recovered,
//                       newCaseCount: state.inReport.todayRecovered,
//                       newCaseRate: state.inReport.recoveredRate,
//                       cardIcon: Icons.healing,
//                     ),
//                   ],
//                 );
//               }

//               return Container(
//                 padding: EdgeInsets.only(top: 50),
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
