import 'package:flutter/material.dart';

class EmptyStatusWidget extends StatelessWidget {
  final String title;
  final int type;
  EmptyStatusWidget({this.title="Empty!",this.type=3});

  IconData gettype(int a) {
    if (a == 0) {
      return Icons.dashboard;
    } else if (a == 1) {
      return Icons.history;
    } else if (a == 2) {
      return Icons.task;
    } else {
      return Icons.priority_high;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Text(
            title,
            style: new TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.green[50],
            ),
          ),
          // Container(
          //     margin: EdgeInsets.only(top: 50),
          //     height: 200,
          //     width: 200,
          //     child: Image.asset(
          //       "assets/images/empty.png",
          //       fit: BoxFit.cover,
          //     )),
          Icon(
            gettype(type),
            size: 100,
            color: Colors.green[50],
          )
        ],
      ),
    );
  }
}
