
// location packgare not woking atyre ****nu  i future use geoloctor

import 'dart:async';
import 'package:bustrackingapp/screens/drivercreens/drawer/driverdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class driverwelcomescreen extends StatefulWidget {
  @override
  State<driverwelcomescreen> createState() => _driverwelcomescreenState();
}

class _driverwelcomescreenState extends State<driverwelcomescreen> {
  bool switch_value = false;

  bool colorsofstart = false;
  bool colorsofend = false;

  late PermissionStatus permissionGranted;
  StreamSubscription<LocationData>? locationsubscription;
  Location location2 = Location();

  void colorchangeofstart_and_listenlocation() async {
    permissionGranted = await location2.hasPermission();
    print(permissionGranted);
    if (permissionGranted == PermissionStatus.denied) {
      print("no");
      permissionGranted = await location2.requestPermission();
    }
    if (permissionGranted == PermissionStatus.granted) {
      print("yes");
      // listenlocation();
      temp();
    }

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

  temp() {
    location2.onLocationChanged.listen((LocationData currentLocation) {
      print(currentLocation.latitude);
    });
  }



  Future<void> listenlocation() async {
    print("chalu");
    locationsubscription = location2.onLocationChanged.handleError((onError) {
      print("$onError");
      // setState(() {
      //   locationsubscription?.cancel();
      //   locationsubscription = null;
      //   print("erorrr");
      // });
    }).listen((LocationData currrentlocation2) async {
      var a = await currrentlocation2.latitude;
      var b = await currrentlocation2.longitude;
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
        print("aaaaa $e");
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
  void initState() {
    // TODO: implement initState
    super.initState();
    location2.requestService();
    location2.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: driverdrawer(),
      appBar: AppBar(
        title: Text("driver home screen"),
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
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
              SizedBox(
                height: 200,
                width: 200,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                      value: switch_value,
                      onChanged: (a) {
                        setState(() {
                          switch_value = a;
                        });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
