// location packgare not woking atyre ****nu  i future use geoloctor

import 'dart:async';
import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/drivercreens/drawer/driverdrawer.dart';
import 'package:bustrackingapp/view_model/driver/driver_welcomescreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class driverwelcomescreen extends StatefulWidget {
  @override
  State<driverwelcomescreen> createState() => _driverwelcomescreenState();
}

class _driverwelcomescreenState extends State<driverwelcomescreen> {
  dynamic driver_welcomescreen_viewmodel = null;
////// geo coder
  ///

  bool switch_value = false;
  bool start_pressed = false;

  void ask_for_permission_and_start_listenlocation() async {
    print("colorchangeofstart_and_listenlocation");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      setState(() {
        // colorsofstart = true;
        start_pressed = true;
      });
      //main func that listen location..
      driver_welcomescreen_viewmodel.upload_live_location(context);
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void stoplisten() {
    print("called stoplisten");

    setState(() {
      driver_welcomescreen_viewmodel.stop_livelocation(context);
      print("stop live location");

      start_pressed = false;
    });
  }

  void milanop() async {
    driver_welcomescreen_viewmodel =
        await Provider.of<Driver_welcomescreen_viewmodel>(context,
            listen: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  onTap: ask_for_permission_and_start_listenlocation,
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
                  onTap: stoplisten,
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
