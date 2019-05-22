import 'package:flutter/material.dart';

bottomNavIconOnly({@required icon, Widget activeIcon, backgroundColor, text}) =>
    BottomNavigationBarItem(
        icon: icon,
        activeIcon: activeIcon,
        backgroundColor: backgroundColor,
        title: text != null
            ? Text(text)
            : Text("", style: TextStyle(fontSize: 0))
        );
