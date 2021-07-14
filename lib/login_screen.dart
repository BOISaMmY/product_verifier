import 'package:flutter/material.dart';
import 'package:product_verifier/my_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/authentication.dart';

class LoginScreen extends StatelessWidget {
  final String title;

  LoginScreen(this.title);

  bool isSignIn = false;
  bool google = false;

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
