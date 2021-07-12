import 'package:flutter/material.dart';

class ProductStatusIcon extends StatelessWidget {
  final int prStatus;
  final String size;
  double iconSize(String s) {
    if (s == 'large')
      return 100;
    else
      return 24;
  }

  ProductStatusIcon(this.prStatus,{this.size="default"});
  Widget statusIcon(status) {
    if (status == 0) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.lightGreen,
        size: iconSize(size),
      );
    } else if (status == 1) {
      return Icon(
        Icons.error_outline,
        color: Colors.orangeAccent,
        size: iconSize(size),
      );
    } else {
      return Icon(
        Icons.highlight_off,
        color: Colors.redAccent,
        size: iconSize(size),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return statusIcon(prStatus);
  }
}
