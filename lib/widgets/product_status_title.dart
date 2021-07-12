import 'package:flutter/material.dart';

class ProductStatusTitle extends StatelessWidget {
  final int prStatus;
  final String size;
  double iconSize(String s) {
    if (s == 'large')
      return 100;
    else
      return 24;
  }

  ProductStatusTitle(this.prStatus, {this.size = "default"});
  Widget statusIcon(status) {
    if (status == 0) {
      return Text(
        "Genuine!",
        style: new TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.lightGreen,
        ),
      );
    } else if (status == 1) {
      return Text(
        "Suspicious?",
        style: new TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.orangeAccent,
        ),
      );
    } else {
      return Text(
        "Fake!",
        style: new TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return statusIcon(prStatus);
  }
}
