import 'package:covid_statistic/widgets/round_image.dart';
import 'package:flutter/material.dart';

class CountryListMenuButton extends StatelessWidget {
  final String fileAndPathName;
  final String semanticLabel;
  final String name;
  final String subtitle;
  final VoidCallback callback;

  CountryListMenuButton(
      {this.fileAndPathName,
      this.semanticLabel,
      this.name,
      this.subtitle,
      this.callback})
      : assert(callback != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: callback,
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: RoundImage(
                      fileAndPathName: fileAndPathName,
                      width: 40,
                      height: 40,
                      semanticLabel: semanticLabel,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color.fromRGBO(19, 137, 253, 1)),
                            )),
                        Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(160, 160, 160, 1)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(Icons.arrow_right_rounded),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
