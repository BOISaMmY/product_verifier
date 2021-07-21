import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_verifier/login_screen.dart';
import 'package:product_verifier/profile_page.dart';
import 'package:product_verifier/request_list_page.dart';
import 'package:product_verifier/scanner_page.dart';

import 'dashboard_page.dart';
import './models/authentication.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  late User _user = widget._user;
  late ProfilePage profpage;
  late PageController _pageController;
  @override
  void initState() {
    _user = widget._user;
    _children.add(QRScanPage(user: _user));
    _children.add(DashboardPage(user: _user));
    _children.add(ProfilePage(_user));
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void logout(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(builder: (_) {
        return LoginScreen("Login");
      }),
    );
  }

  void requestsPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return RequestListPage(
        user: _user,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              requestsPage(context);
            },
            icon: Icon(Icons.receipt),
          ),
          IconButton(
            onPressed: () async {
              await Authentication.signOut(context: context);
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
