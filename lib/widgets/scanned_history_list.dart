import 'package:flutter/material.dart';
import '../models/product.dart';

class ScannedHistoryList extends StatelessWidget {
  final List<Product> productHistory;
  final Function deletePr;

  ScannedHistoryList(this.productHistory, this.deletePr);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      child: SingleChildScrollView(
        child: Column(
          children: productHistory.reversed.map((pr) {
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Container(
                      child: Icon(Icons.image),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.blue.shade50,
                        ),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    Column(
                      children: [
                        Text(pr.id),
                        Text(pr.name),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    deletePr(pr);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
