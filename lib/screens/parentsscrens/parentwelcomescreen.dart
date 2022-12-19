import 'package:bustrackingapp/screens/parentsscrens/parentdrawerwidget.dart';
import 'package:flutter/material.dart';

class parentwelcomescreen extends StatelessWidget {
  const parentwelcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("parent home screen")),
      drawer: parentdrawer(),
      body: Container(
        child: Column(children: [
          
        ],),
      ),
    );
  }
}
