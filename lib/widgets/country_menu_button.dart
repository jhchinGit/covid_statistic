import 'package:covid_statistic/widgets/round_image.dart';
import 'package:flutter/material.dart';

class CountryMenuButton extends StatelessWidget {
  final String fileAndPathName;
  final String semanticLabel;
  final String name;
  final VoidCallback callback;

  CountryMenuButton(
      {this.fileAndPathName, this.semanticLabel, this.name, this.callback})
      : assert(callback != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 8.0,
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
                  semanticLabel: semanticLabel,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(19, 137, 253, 1)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
