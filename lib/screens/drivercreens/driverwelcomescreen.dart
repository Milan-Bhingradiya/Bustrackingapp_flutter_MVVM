// location packgare not woking atyre ****nu  i future use geoloctor

import 'dart:async';
import 'package:bustrackingapp/screens/drivercreens/drawer/driverdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class driverwelcomescreen extends StatefulWidget {
  @override
  State<driverwelcomescreen> createState() => _driverwelcomescreenState();
}

class _driverwelcomescreenState extends State<driverwelcomescreen> {
////// geo coder

  late StreamSubscription<Position> positionStream;

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );

  bool switch_value = false;
  bool start_pressed = false;

  void colorchangeofstart_and_listenlocation() async {
    print("colorchangeofstart_and_listenlocation");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() {
        // colorsofstart = true;

        start_pressed = true;
      });
      listenlocation();
    }
  }

  Future<void> listenlocation() async {
    //maybe this track  not stop from trcking ther is another thing like
    //positionStream.cancle like this.....

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
      try {
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc('ramu3')
            .update({
          'letitude': position?.latitude,
          'longitude': position?.longitude,
        });
        print("submit");
      } catch (e) {
        print("aaaaa ${e.toString()}");
      }
    });

    print("strat live location");
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void colorchangeofend_and_stoplisten() {
    print("colorchangeofend_and_stoplisten");
    stoplistening();
    setState(() {
      start_pressed= false;
    });
  }

  void stoplistening() {
    setState(() {
      if (positionStream == null) {
      } else {
        positionStream.cancel();
        print("stop live location");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // if (positionStream == null) {

    // } else {
    //   positionStream.cancel();
    // }
    positionStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: driverdrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          elevation: 0,
          backgroundColor: Colors.amber[400],
          actions: [
            SizedBox(
              height: 100,
              width: 70,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                    inactiveThumbColor: Colors.red,
                    activeColor: Colors.green,
                    value: start_pressed,
                    onChanged: (a) {
                      // setState(() {
                      //   switch_value = true;
                      // });
                    }),
              ),
            ),
          ],
          title: Text(
            "driver home screen",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      // drawer: parentdrawer(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: colorchangeofstart_and_listenlocation,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: start_pressed
                              ? [
                                  BoxShadow(
                                      color: Colors.grey.shade500,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(4, 4)),
                                  BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(-4, -4))
                                ]
                              : []),
                      height: 70,
                      width: 200,
                      child: Text(
                        "START",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ))),
              SizedBox(
                height: 40,
              ),

              GestureDetector(
                  onTap: colorchangeofend_and_stoplisten,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: !start_pressed
                              ? [
                                  BoxShadow(
                                      color: Colors.grey.shade500,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(4, 4)),
                                  BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(-4, -4))
                                ]
                              : []),
                      height: 70,
                      width: 200,
                      child: Text(
                        "STOP",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ))),

              // GestureDetector(
              //     onTap: colorchangeofend_and_stoplisten,
              //     child: Container(
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             color: end_pressed ? Colors.green : Colors.red,
              //             borderRadius: BorderRadius.all(Radius.circular(15))),
              //         height: 50,
              //         width: 200,
              //         child: Text(
              //           "END",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 30,
              //               fontWeight: FontWeight.w800),
              //         ))),
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
