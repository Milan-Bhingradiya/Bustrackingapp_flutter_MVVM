import 'dart:async';

import 'package:bustrackingapp/screens/drivercreens/driverdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class driverwelcomescreen extends StatefulWidget {
  @override
  State<driverwelcomescreen> createState() => _driverwelcomescreenState();
}

class _driverwelcomescreenState extends State<driverwelcomescreen> {
  bool colorsofstart = false;
  bool colorsofend = false;

  StreamSubscription<LocationData>? locationsubscription;
  Location location = Location();

  void colorchangeofstart_and_listenlocation() {
    listenlocation();
    setState(() {
      colorsofstart = true;
      colorsofend = false;
    });
  }

  void colorchangeofend_and_stoplisten() {
    stoplistening();
    setState(() {
      colorsofend = true;
      colorsofstart = false;
    });
  }

  Future<void> listenlocation() async {
    locationsubscription = location.onLocationChanged.handleError((onError) {
      print("mmmmmmmmmmmmmmmmmmmmmmmmmm $onError");
      locationsubscription?.cancel();
      setState(() {
        locationsubscription = null;
        print("erorrrrrrrrrrrrrrr");
      });
    }).listen((LocationData currrentlocation2) async {
      final a = currrentlocation2.latitude;
      final b = currrentlocation2.longitude;
      try {
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc('ramu3')
            .update({
          'letitude': a,
          'longitude': b,
        });
        print("submit");
      } catch (e) {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
      }
    });
    print("strat live location");
  }

  void stoplistening() {
    locationsubscription?.cancel();
    setState(() {
      locationsubscription = null;
    });
    print("stop live location");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: driverdrawer(),
      appBar: AppBar(title: Text("driver home screen")),
      // drawer: parentdrawer(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                  onTap: colorchangeofstart_and_listenlocation,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colorsofstart ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: 50,
                      width: 200,
                      child: Text(
                        "START",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ))),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                  onTap: colorchangeofend_and_stoplisten,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colorsofend ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: 50,
                      width: 200,
                      child: Text(
                        "END",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ))),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
