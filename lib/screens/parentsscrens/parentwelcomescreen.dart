import 'dart:async';

import 'package:bustrackingapp/screens/parentsscrens/dummy.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentdrawerwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider.dart';

class parentwelcomescreen extends StatefulWidget {
  const parentwelcomescreen({super.key});

  @override
  State<parentwelcomescreen> createState() => _parentwelcomescreenState();
}

class _parentwelcomescreenState extends State<parentwelcomescreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // here i check if already i assign icon to variable
    //then bypass assign icon to bus

    if (!Provider.of<Alldata>(context, listen: false)
        .marker_of_home_and_bus_set) {
      Provider.of<Alldata>(context, listen: false)
          .callgetbytefromassetforhomeicon();

      Provider.of<Alldata>(context, listen: false)
          .callgetbytefromassetforbusicon();

      Provider.of<Alldata>(context, listen: false).marker_of_home_and_bus_set =
          true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("parent home screen")),
      drawer: parentdrawer(),
      body: Container(
        child: Column(
          children: [
            // for checking i am able to make stream or not just for example
            GestureDetector(
              onTap: () {
                print("touch");

                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => dummy())));

                // print(DocumentSnapshot.);
              },
              child: Container(height: 200, width: 200, color: Colors.amber),
            )
          ],
        ),
      ),
    );
  }
}
