import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_verifier/widgets/product_category_image.dart';
import './history_product_details.dart';
import '../models/product.dart';
import './product_status_icon.dart';

class ScannedHistoryList extends StatelessWidget {
  final List<Product> productHistory;
  final Function deletePr;
  final User _user;
  // ScannedHistoryList(this.productHistory, this.deletePr,{required User user});

  const ScannedHistoryList({Key? key, required User user, required Function adeletepr,required List<Product> aproductHistory,})
      : _user = user,
        deletePr = adeletepr,
        productHistory = aproductHistory,
        super(key: key);

  showProductDetails(BuildContext ctx, Product pr,User u) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return HistoryProductDetails(pr,u);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      child: SingleChildScrollView(
        child: Column(
          children: productHistory.reversed.map((pr) {
            return Card(
              child: ListTile(
                onTap: () {
                  showProductDetails(context, pr,_user);
                },
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
                      // padding: EdgeInsets.all(2),
                    ),
                    Column(
                      children: [
                        Text(
                          pr.id,
                          style: new TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(pr.name,
                            style: new TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProductStatusIcon(pr.status),
                    IconButton(
                      onPressed: () {
                        deletePr(pr);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
