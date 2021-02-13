import 'package:covid_statistic/widgets/round_image.dart';
import 'package:flutter/material.dart';

class CountryMenuButton extends StatelessWidget {
  final String fileAndPathName;
  final String name;
  final VoidCallback callback;

  CountryMenuButton({this.fileAndPathName, this.name, this.callback})
      : assert(callback != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: callback,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundImage(
                  fileAndPathName: fileAndPathName,
                  width: 60,
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
