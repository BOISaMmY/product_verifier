import 'package:flutter/material.dart';
import 'package:product_verifier/models/urls.dart';
import 'package:product_verifier/widgets/product_status_title.dart';
import './product_status_icon.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class HistoryProductDetails extends StatelessWidget {
  final Product pr;
  final User _user;
  HistoryProductDetails(this.pr, this._user);
  final TextStyle tableHeaders = new TextStyle(
    fontWeight: FontWeight.w900,
  );
  final TextStyle tableItems = new TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  void requestTransfer(Product pr) {
    const url = URLS.base+"createtransferrequest";
    print("YEAHHHHHHHHHHHHHHH");
    String par = json.encode(<String, String>{
      'rid': pr.curOwner,
      'pid': pr.id,
      'sid': _user.email.toString()
    });
    print(par);
    http
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: par,
        )
        .then((response) {});
  }

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
          headingRowHeight: 0.0,
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
                Text(
                  pr.id,
                  style: tableItems,
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text(
                  "Product Name: ",
                  style: tableHeaders,
                ),
              ),
              DataCell(
                Text(
                  pr.name,
                  style: tableItems,
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text(
                  "Product Manufacturer: ",
                  style: tableHeaders,
                ),
              ),
              DataCell(
                Text(
                  pr.manufacturer,
                  style: tableItems,
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text(
                  "Current Owner: ",
                  style: tableHeaders,
                ),
              ),
              DataCell(
                Text(
                  pr.curOwner,
                  style: tableItems,
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text(
                  "Product Type: ",
                  style: tableHeaders,
                ),
              ),
              DataCell(
                Text(
                  pr.type,
                  style: tableItems,
                ),
              ),
            ]),
          ],
        ),
        TextButton(
          onPressed: () {
            requestTransfer(pr);
          },
          child: Text("Request"),
        ),
      ],
    );
  }
}
