import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_verifier/main.dart';
import 'package:product_verifier/models/urls.dart';
import './models/requests.dart';
import 'widgets/empty_status_widget.dart';
import 'widgets/product_category_image.dart';

class RequestListPage extends StatefulWidget {
  const RequestListPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _RequestListPageState createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  late User _user = widget._user;
  final List<Request> pendingRequests = [];
  // late String email = _user.email;
  void getPendingRequests() {
    const url = URLS.base + "transferrequests";
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

        final newReq = Request(
          pid: itr.current['pid'],
          sid: itr.current['sid'],
          rid: itr.current['rid'],
          pmanf: itr.current['pmanf'],
          pname: itr.current['pname'],
          ptype: itr.current['ptype'],
          curOwner: itr.current['curOwner'],
        );
        pendingRequests.add(newReq);
      }
      setState(() {});
    });
  }

  void deleteTransferRequest(Request req) {
    const url = URLS.base + "deletetransferrequest";
    String par = json.encode(
        <String, String>{'rid': req.rid, 'pid': req.pid, 'sid': req.sid});
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
      pendingRequests.remove(req);
      setState(() {});
    });
  }

  void acceptTransferRequest(Request req) {
    const url = URLS.base + "accepttransferrequest";
    String par = json.encode(
        <String, String>{'rid': req.rid, 'pid': req.pid, 'sid': req.sid});
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
      pendingRequests.remove(req);
      setState(() {});
    });
  }

  @override
  void initState() {
    _user = widget._user;
    print("initstate called!");
    getPendingRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Requests"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        height: 580,
        child: pendingRequests.isEmpty
            ? Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyStatusWidget(
                      title: "You don't have any \npending requests...",
                      type: 2,
                    ),
                ],
              ),
            )
            : SingleChildScrollView(
                child: Column(
                  children: pendingRequests.reversed.map((pr) {
                    return Card(
                      child: ListTile(
                        onTap: () {},
                        title: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: ProductCategoryImage(pr.ptype),
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
                                    pr.pid,
                                    style: new TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    pr.pname,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    pr.sid,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                acceptTransferRequest(pr);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteTransferRequest(pr);
                              },
                              icon: Icon(
                                Icons.close,
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
      ),
    );
  }
}
