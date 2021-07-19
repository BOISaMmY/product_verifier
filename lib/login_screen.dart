import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product_verifier/my_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/authentication.dart';
import 'models/urls.dart';

class LoginScreen extends StatelessWidget {
  final String title;

  LoginScreen(this.title);

  void mainPage(BuildContext ctx, User user) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(builder: (_) {
        return MyHomePage(
          title: "Product Verifier",
          user: user,
        );
      }),
    );
  }

  void loginBackend(User user){
    const url = URLS.base+"login";
    print("YEAHHHHHHHHHHHHHHH");
    String par = json.encode(<String, String>{
      'name': user.displayName.toString(),
      'email': user.email.toString()
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.greenAccent,
      ),
      body: FutureBuilder(
        future: Authentication.initializeFirebase(context: context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error initializing Firebase');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ElevatedButton(
                child: Text("continue"),
                onPressed: () async {
                  User? user =
                      await Authentication.signInWithGoogle(context: context);

                  if (user != null) {
                    loginBackend(user);
                    mainPage(context, user);
                  }
                });
          }
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.orangeAccent,
            ),
          );
        },
      ),
    );
  }
}
