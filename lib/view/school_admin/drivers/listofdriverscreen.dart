import 'dart:async';
import 'dart:ui';

import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/drivers/adddriverscreen.dart';
import 'package:bustrackingapp/view/school_admin/drivers/editdriverscreen.dart';
import 'package:bustrackingapp/view_model/schooladmin/driver/schooladmin_driver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/driver/schooladmin_editdriver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../drawer/admindrawerwidget.dart';

class listofdriverscreen extends StatefulWidget {
  @override
  State<listofdriverscreen> createState() => _listofdriverscreenState();
}

class _listofdriverscreenState extends State<listofdriverscreen> {
  dynamic schooladmin_login_viewmodel = null;

  QuerySnapshot? querySnapshot;
  dynamic schooladmin_driver_viewmodel = null;

//this for set driver_doc id inside schooladmin driver edit screen viremodel..
  dynamic schooladmin_editdriver_viewmodel = null;

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

    schooladmin_driver_viewmodel =
        Provider.of<Schooladmin_driver_viewmodel>(context, listen: false);

    schooladmin_editdriver_viewmodel =
        Provider.of<Schooladmin_editdriver_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: admindrawer(),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "All Driver of our schhol",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFF76a6f0),
        elevation: 0,
      ),
      body: Stack(
        children: [
          //layer1
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xFF76a6f0),
                  )),
              Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                  ))
            ],
          ),
          //stack layer2
          Padding(
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
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
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
                        .doc(schooladmin_login_viewmodel.institute_doc_id)
                        .collection("drivers")
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(schooladmin_login_viewmodel.institute_doc_id);
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
                              return Dismissible(
                                key: UniqueKey(),
                                secondaryBackground: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "DELETE",
                                        style: TextStyle(
                                            fontFamily: "Playfair Display",
                                            fontSize: size.width / 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: size.width / 10,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                background: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "EDIT",
                                        style: TextStyle(
                                            fontFamily: "Playfair Display",
                                            fontSize: size.width / 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: size.width / 10,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                confirmDismiss: (direction) {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Please confirm"),
                                          content: Text(
                                              "are you sure you want to edit?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);

// write this logic here because i dont want to remove tile from dismissble wdget also thats why upper line return false
                                                  schooladmin_editdriver_viewmodel
                                                          .driver_doc_id =
                                                      snapshot
                                                          .data!.docs[index].id
                                                          .toString();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            editdriverscreen(),
                                                      ));
                                                },
                                                child: Text("Yes")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text("No"))
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Please confirm"),
                                          content: Text(
                                              "are you sure you want to delete?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text("Yes")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text("No"))
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                onDismissed:
                                    (DismissDirection direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    //logic to delete
                                    bool result =
                                        await schooladmin_driver_viewmodel
                                            .delete_driver(context,
                                                snapshot.data!.docs[index].id);
                                    if (result) {
                                      Fluttertoast.showToast(msg: "aaa");
                                    }
                                  }

                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    schooladmin_editdriver_viewmodel
                                            .driver_doc_id =
                                        snapshot.data!.docs[index].id
                                            .toString();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              editdriverscreen(),
                                        ));
                                  }
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 22),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 10,
                                      child: Container(
                                        height: size.height / 5.8,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 225, 222, 222),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Row(
                                          children: [
                                            SizedBox(width: size.width / 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(
                                                      snapshot
                                                          .data!
                                                          .docs[index][
                                                              "profile_img_link"]
                                                          .toString()),
                                                ),
                                                Text(
                                                  //  " ${index + 1} Driver name : ${snapshot.data!.docs[index]['drivername']}"),
                                                  " ${snapshot.data!.docs[index]['drivername']}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Playfair Display",
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Phone num :",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Playfair Display",
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "${snapshot.data!.docs[index]['driverphonenumber'].toString()},",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Source Serif Pro",
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )),

                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Bus num :",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Playfair Display",
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "${snapshot.data!.docs[index]['busnum'].toString()}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Source Serif Pro",
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )),
                                                  // SizedBox(
                                                  //   height: 6,
                                                  // )
                                                ]),
                                          ],
                                        ),
                                      ),
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
        ],
      ),
    );
  }
}
