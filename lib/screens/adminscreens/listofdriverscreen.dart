import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admindrawerwidget.dart';

class listofdriverscreen extends StatefulWidget {
  @override
  State<listofdriverscreen> createState() => _listofdriverscreenState();
}

class _listofdriverscreenState extends State<listofdriverscreen> {
  late String drivername;

  late String driverphonenumber;

  late String driverpassword1;
  late String driverpassword2;
  late String confirmdriverpassword;

  bool checkconfirmpassword = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: admindrawer(),
      appBar: AppBar(
        title: Text("All drivers of our school"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.drive_eta_rounded,
                  size: 30,
                ),
                SizedBox(
                  child: Text("DRIVER"),
                  width: 180,
                ),
                GestureDetector(
                  onTap: () {
                    print("aaaa");
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return Dialog(
                              child: Container(
                            width: double.infinity,
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "ADD driver info",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Enter Driver name"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        drivername = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText:
                                              "Enter Driver phone number"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        driverphonenumber = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Enter password"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        driverpassword1 = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Colors.amber,
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Enter confirm password",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        }

                                        if (driverpassword1 !=
                                            driverpassword2) {
                                          return "password mismatch";
                                        }
                                        if (driverpassword1 ==
                                            driverpassword2) {
                                          confirmdriverpassword =
                                              driverpassword2;
                                        }
                                      },
                                      onChanged: ((value) {
                                        driverpassword2 = value;
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  // DropdownButton(items: , onChanged: onChanged)
                                  GestureDetector(
                                    onTap: () async {
                                      if (formkey.currentState!.validate()) {
                                        print("succesful");
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('drivers')
                                              .doc(drivername)
                                              .set({
                                            'drivername': drivername,
                                            'driverphonenumber':
                                                driverphonenumber,
                                            'password': confirmdriverpassword,
                                            'busnum': "",
                                          });
                                        } catch (e) {
                                          print(
                                              "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
                                        } on Exception {
                                          print("zzzzzzzzzzzzzzzzzzzzzz");
                                        }
                                        ;
                                      } else {
                                        print("unsuccesful");
                                      }
                                      Navigator.pop(context);
                                      // FirebaseFirestore.instance.collection('drivers').doc('')
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 100,
                                      color: Colors.deepPurple,
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                        },
                        fullscreenDialog: true));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 80,
                      color: Colors.grey[800],
                      child: Text(
                        "ADD",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
            height: 10,
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('drivers').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        return Align(
                          child: Material(
                            elevation: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(0)),
                              margin: EdgeInsets.only(bottom: 20),
                              width: 280,
                              height: 90,
                              child: Column(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Text(
                                      " ${index + 1} Driver name : ${snapshot.data!.docs[index]['drivername']}"),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                        "phonenumber : ${snapshot.data!.docs[index]['driverphonenumber'].toString()}")),
                                // SizedBox(
                                //   height: 6,
                                // )
                              ]),
                            ),
                          ),
                        );

                        ListTile(
                          title: Text(snapshot.data!.docs[index]['drivername']
                              .toString()),
                          subtitle: Text(snapshot
                              .data!.docs[index]['driverphonenumber']
                              .toString()),
                        );
                      }),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
