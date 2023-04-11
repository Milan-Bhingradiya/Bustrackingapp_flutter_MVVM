import 'dart:async';
import 'dart:ui';

import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/drivers/adddriverscreen.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_driver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../drawer/admindrawerwidget.dart';

class listofdriverscreen extends StatefulWidget {
  @override
  State<listofdriverscreen> createState() => _listofdriverscreenState();
}

class _listofdriverscreenState extends State<listofdriverscreen> {
  dynamic schooladmin_login_viewmodel = null;

  QuerySnapshot? querySnapshot;

  // bool driver_collection_is_empty = true;
  // void check_driver_collection_is_empty_or_not() async {
  //   querySnapshot = await FirebaseFirestore.instance
  //       .collection('main')
  //       .doc("main_document")
  //       .collection("institute_list")
  //       .doc(institute_name)
  //       .collection("drivers")
  //       .get();

  //   print(querySnapshot!.size);
  //   if (querySnapshot!.size >= 1) {
  //     setState(() {
  //       driver_collection_is_empty = false;
  //     });
  //   } else {
  //     setState(() {
  //       driver_collection_is_empty = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schooladmin_login_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: admindrawer(),
      appBar: AppBar(
        title: Text("All drivers of our school"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Driver",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("aaaa");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return adddriverscreen();
                        },
                      ));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 80,
                        color: Colors.amber,
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('main')
                    .doc("main_document")
                    .collection("institute_list")
                    .doc(schooladmin_login_viewmodel.institutename)
                    .collection("drivers")
                    .snapshots(),
                builder: (context, snapshot) {
                  print(schooladmin_login_viewmodel.institutename);
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print(snapshot.data!.size);
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 22),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 10,
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 225, 222, 222),
                                    borderRadius: BorderRadius.circular(9)),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 48,
                                          backgroundImage: AssetImage(
                                              "assets/images/bus.png"),
                                        )
                                      ],
                                    ),
                                    Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Text(
                                            //  " ${index + 1} Driver name : ${snapshot.data!.docs[index]['drivername']}"),
                                            " ${snapshot.data!.docs[index]['drivername']}"),
                                      ),

                                      Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 250,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Text(
                                              "Phone num :  ${snapshot.data!.docs[index]['driverphonenumber'].toString()}")),

                                      Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 250,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Text(
                                              "Bus num :  ${snapshot.data!.docs[index]['busnum'].toString()}")),
                                      // SizedBox(
                                      //   height: 6,
                                      // )
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          );

                          // ListTile(
                          //   title: Text(snapshot.data!.docs[index]['drivername']
                          //       .toString()),
                          //   subtitle: Text(snapshot
                          //       .data!.docs[index]['driverphonenumber']
                          //       .toString()),
                          // );
                        }),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
