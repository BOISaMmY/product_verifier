import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_verifier/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:product_verifier/widgets/empty_status_widget.dart';
import './widgets/product_category_image.dart';
import 'models/urls.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late User _user = widget._user;
  final List<Product> ownedProducts = [];
  void getOwnedProducts() {
    const url = URLS.base + "ownedproducts";
    String par = json.encode(<String, String>{'rid': _user.email.toString()});
    print(par);
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
      var itr = res.iterator;
      while (itr.moveNext()) {
        print(itr.current);

        final newPr = Product(
          id: itr.current['pid'],
          manufacturer: itr.current['pmanf'],
          name: itr.current['pname'],
          type: itr.current['ptype'],
          curOwner: itr.current['curOwner'],
        );
        ownedProducts.add(newPr);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    _user = widget._user;
    getOwnedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
          dataRowHeight: 0.0,
          columns: [
            DataColumn(
                label: Text(
              "Your Products:",
              style: new TextStyle(fontSize: 16),
            ))
          ],
          rows: [
            DataRow(cells: [DataCell(Text(""))])
          ],
        ),
        Container(
          height: 580,
          child: ownedProducts.isEmpty
              ? EmptyStatusWidget(title: "You currently don't \nown any products...", type: 0,)
              : SingleChildScrollView(
                  child: Column(
                    children: ownedProducts.reversed.map((pr) {
                      return Card(
                        child: ListTile(
                          onTap: () {},
                          title: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: ProductCategoryImage(pr.type),
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blue.shade50,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pr.id,
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      pr.name,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      pr.manufacturer,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ),
      ],
    );
  }
}
