import 'package:bustrackingapp/screens/school_admin/drawer/admindrawerwidget.dart';
import 'package:bustrackingapp/screens/studentloginscreen.dart';
import 'package:flutter/material.dart';

class adminhomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("School Admin")),
      drawer: admindrawer(),
      body: Center(
        child: Container(
          child: Icon(
            Icons.person,
            size: 200,
          ),
        ),
      ),
    );
  }
}
