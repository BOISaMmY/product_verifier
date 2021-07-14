import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final User _user;

  ProfilePage(User user) : _user = user;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        Image.network(_user.photoURL!),
      ],)
    );
  }
}
