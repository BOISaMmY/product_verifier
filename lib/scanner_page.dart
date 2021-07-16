import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:product_verifier/widgets/scanned_history_list.dart';
import './models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final List<Product> productHistory = [
    Product(
      id: '001',
      manufacturer: 'classmate',
      name: 'notebook',
      type: 'stationary',
    ),
    Product(
      id: '002',
      manufacturer: 'Xiaomi',
      name: "POCO F1",
      type: 'gadget',
    ),
  ];
  String qrCode = 'Unknown';
  int newScan = 1;

  void addNewHistory(String pId, String pManf, String pName, String pType) {
    const url = "http://223.181.131.142:8081/verify";
    String par = json.encode(<String, String>{'manf': pManf, 'id': pId});
    // String req = '{"manf":"samco","id": "1"}';
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
      print(res);
      final newEntry = Product(
        id: pId,
        manufacturer: pManf,
        name: pName,
        type: pType,
        status: res['stat'],
        curOwner: res['owner'],
      );
      productHistory.add(newEntry);
      setState(() {
        
      });
    });
  }

  void deleteProductCard(Product p) {
    setState(() {
      productHistory.remove(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (newScan == 1) {
      scanQRCode();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(12),
            tileColor: Colors.blue[50],
            onTap: () => setState(() {
              newScan = 1;
            }),
            title: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "New Scan",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
        ScannedHistoryList(productHistory, deleteProductCard),
      ],
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCodeResult;

        newScan = 0;
      });
      Map productValueMap = json.decode(qrCodeResult);
      addNewHistory(
        productValueMap['id'],
        productValueMap['manufacturer'],
        productValueMap['name'],
        productValueMap['type'],
      );
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
