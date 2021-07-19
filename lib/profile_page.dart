import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'models/urls.dart';

class ProfilePage extends StatelessWidget {
  final User _user;

  ProfilePage(User user) : _user = user;

  String getUserDesignation() {
    const url = URLS.base + "getuserdesignation";
    String par = json.encode(<String, String>{'id': _user.email.toString()});
    http
        .post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: par,
    )
        .then((response) {
      var res = json.decode(response.body);
      return res['designation'];
    });
    return 'consumer';
  }

  final TextStyle tableHeaders = new TextStyle(
    fontWeight: FontWeight.w900,
  );
  final TextStyle tableItems = new TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Card(
                child: Container(
              child: Image.network(
                _user.photoURL!,
                height: 200,
                fit: BoxFit.cover,
              ),
              width: 400,
              height: 400,
            )),
            Container(
              width: double.infinity,
              child: Card(
                child: DataTable(
                  headingRowHeight: 0.0,
                  dividerThickness: 0.0,
                  columns: [
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Text("Name: ", style: tableHeaders),
                      ),
                      DataCell(
                        Text(
                          _user.displayName.toString(),
                          style: tableItems,
                        ),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          "Email ",
                          style: tableHeaders,
                        ),
                      ),
                      DataCell(
                        Text(
                          _user.email.toString(),
                          style: tableItems,
                        ),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          "Role: ",
                          style: tableHeaders,
                        ),
                      ),
                      DataCell(
                        Text(
                          getUserDesignation(),
                          style: tableItems,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
