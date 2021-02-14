import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String fileAndPathName;
  final String semanticLabel;
  final double width;
  final double height;

  RoundImage(
      {this.fileAndPathName, this.semanticLabel, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.asset(
          fileAndPathName,
          width: width,
          height: height,
          fit: BoxFit.fill,
          semanticLabel: semanticLabel,
        ));
  }
}
