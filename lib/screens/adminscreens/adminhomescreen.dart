import 'package:bustrackingapp/screens/adminscreens/admindrawerwidget.dart';
import 'package:bustrackingapp/screens/adminscreens/listofparentsscreen.dart';
import 'package:bustrackingapp/screens/studentloginscreen.dart';
import 'package:flutter/material.dart';

class adminhomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ooooooo")),
      drawer: admindrawer(),
      body: Container(),
    );
  }
}
