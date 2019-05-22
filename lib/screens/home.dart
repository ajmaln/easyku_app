import 'package:easyku_app/screens/pages/about.dart';
import 'package:easyku_app/screens/pages/notifications.dart';
import 'package:easyku_app/screens/pages/results.dart';
import 'package:easyku_app/widgets/BottomNavIconOnly.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("easyKU", style: TextStyle(color: Colors.black87),),
      //   backgroundColor: Colors.white,
      // ),
      appBar: GradientAppBar(
        title: Text("easyKU", style: TextStyle(color: Colors.white),),
        backgroundColorStart: Colors.red,
        backgroundColorEnd: Colors.blueAccent,
      ),

      body: [
        Result(),
        Notifications(),
        AboutPage(),
      ][currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (currentTab) {
          setState(() {
            currentPage = currentTab;
          });
        },
        items: [
          bottomNavIconOnly(icon: Icon(Icons.list), text: "Results"),
          bottomNavIconOnly(icon: Icon(Icons.info), text: "Notifications"),
          bottomNavIconOnly(icon: Icon(Icons.dashboard), text: "About"),
        ],
      ),
    );
  }
}