import 'package:flutter/material.dart';
import 'package:product_verifier/widgets/product_status_title.dart';
import './product_status_icon.dart';
import '../models/product.dart';

class HistoryProductDetails extends StatelessWidget {
  final Product pr;
  HistoryProductDetails(this.pr);
  final TextStyle tableHeaders = new TextStyle(
    fontWeight: FontWeight.w900,
  );
  final TextStyle tableItems = new TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ProductStatusIcon(
                pr.status,
                size: 'large',
              ),
              ProductStatusTitle(pr.status),
            ],
          ),
        ),
        DataTable(
          columns: [
            DataColumn(label: Text('')),
            DataColumn(label: Text('')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Text("Product ID: ", style: tableHeaders),
              ),
              DataCell(
                Text(pr.id,style: tableItems,),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text("Product Name: ",style: tableHeaders,),
              ),
              DataCell(
                Text(pr.name, style: tableItems,),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text("Product Manufacturer: ",style: tableHeaders,),
              ),
              DataCell(
                Text(pr.manufacturer,style: tableItems,),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text("Product Type: ",style: tableHeaders,),
              ),
              DataCell(
                Text(pr.type,style: tableItems,),
              ),
            ]),
          ],
        )
      ],
    );
  }
}
