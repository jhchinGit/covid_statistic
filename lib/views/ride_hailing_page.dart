import 'package:covid_statistic/bloc/bloc.dart';
import 'package:covid_statistic/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

class RideHailingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, dynamic>(builder: (context, state) {
      return ListView(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
        children: [
          CountryListMenuButton(
              fileAndPathName: 'images/flag_my.png',
              name: "MALAYSIA",
              subtitle: "View google map",
              callback: () async {
                var location = new Location();

                var serviceEnabled = await location.serviceEnabled();
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                  if (!serviceEnabled) {
                    showPermissionAlert(
                        context, "Please enable device location.");
                    return;
                  }
                }

                var permissionGranted = await location.hasPermission();
                if (permissionGranted == PermissionStatus.denied) {
                  permissionGranted = await location.requestPermission();
                  if (permissionGranted != PermissionStatus.granted) {
                    showPermissionAlert(
                        context, "Require location permission to run.");
                    return;
                  }
                }

                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigateToMapEvent());
              }),
        ],
      );
    });
  }

  void showPermissionAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                "Permission Required!",
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Text(message),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              elevation: 8,
              backgroundColor: Color.fromRGBO(22, 199, 154, 1),
            ),
        barrierDismissible: false);
  }
}
