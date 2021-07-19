import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:product_verifier/my_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:product_verifier/widgets/simple_round_icon_button.dart';
import '../models/authentication.dart';
import 'models/urls.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
            return Container(
              color: Colors.blue[50],
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(width:200,height: 200,child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,)),
                Text("ProVeri",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 40,color: Colors.blueAccent),),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: SimpleRoundIconButton(
                        backgroundColor: Colors.orange,
                        buttonText: Text("Continue with Google",style: TextStyle(color: Colors.white),),
                        icon: Icon(FontAwesomeIcons.google),
                        onPressed: () async {
                          User? user =
                              await Authentication.signInWithGoogle(context: context);

                          if (user != null) {
                            loginBackend(user);
                            mainPage(context, user);
                          }
                        }),
                  ),
                ],
              ),
            );
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
