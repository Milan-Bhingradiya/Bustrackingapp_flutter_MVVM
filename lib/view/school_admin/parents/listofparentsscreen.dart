import 'dart:async';

import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/parents/addnewparents_screen.dart';
import 'package:bustrackingapp/view/school_admin/parents/editparentscreen.dart';
import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_editparent_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_homescreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_parent_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../drawer/admindrawerwidget.dart';

class listofparentsscreen extends StatefulWidget {
  const listofparentsscreen({super.key});

  @override
  State<listofparentsscreen> createState() => _listofparentsscreenState();
}

class _listofparentsscreenState extends State<listofparentsscreen> {
  late String parentname;
  late String parentphonenumber;
  late String parentchildname;
  late String password1;
  late String password2;
  late String finalpassword;
  late String childname;
  late String drivername;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? institute_doc_id;
  dynamic schooladmin_parent_viewmodel = null;

  //this for set parent_doc id inside schooladmin parent edit screen viremodel..
  dynamic schooladmin_editparent_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    institute_doc_id =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false)
            .institute_doc_id;

    schooladmin_parent_viewmodel =
        Provider.of<Schooladmin_parent_viewmodel>(context, listen: false);

    schooladmin_editparent_viewmodel =
        Provider.of<Schooladmin_editparent_viewmodel>(context, listen: false);
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
          "All Parents of our school",
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
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Parents",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 80,
                            color: Colors.amber,
                            child: Text("ADD")),
                        onTap: () {
                          print("aaaa");

                          try {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => addnewparents_screen(),
                                ));
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder(
                    // stream: FirebaseFirestore.instance
                    //     .collection('parents')
                    //     .snapshots(),

                    stream: FirebaseFirestore.instance
                        .collection('main')
                        .doc("main_document")
                        .collection("institute_list")
                        .doc(institute_doc_id.toString())
                        .collection("parents")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                // direction: DismissDirection.endToStart,
                                secondaryBackground: Container(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: size.width / 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                background: Container(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: size.width / 10,
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
                                                  setState(() {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                    schooladmin_editparent_viewmodel
                                                            .parent_doc_id =
                                                        snapshot.data!
                                                            .docs[index].id
                                                            .toString();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              editparentscreen(),
                                                        ));
                                                  });
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
                                        await schooladmin_parent_viewmodel
                                            .delete_parent(context,
                                                snapshot.data!.docs[index].id);
                                    if (result) {
                                      Fluttertoast.showToast(
                                          msg: "Successfully deleted");
                                    }
                                  }
                                },
                                child: Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    child: Container(
                                      height: size.height / 4.9,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 225, 222, 222),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      child: Row(
                                        children: [
                                          SizedBox(width: size.width / 20),
                                          ////////
                                          Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: size.height / 40,
                                              ),
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ["profile_img_link"]
                                                        .toString()),
                                              ),
                                              SizedBox(
                                                height: size.height / 50,
                                              ),
                                              Text(
                                                //  " ${index + 1} Driver name : ${snapshot.data!.docs[index]['drivername']}"),
                                                " ${snapshot.data!.docs[index]['parentname']}",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Playfair Display",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),

                                          //////////////
                                          // Column(
                                          //   children: [
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10),
                                          //       child: Text(
                                          //         (index + 1).toString() + ")",
                                          //         style: TextStyle(fontSize: 25),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),

                                          /////////////
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                height: size.height / 22,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Parent name:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Playfair Display",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${snapshot.data!.docs[index]['parentname'].toString()}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Source Serif Pro",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height / 150,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Mobile Num:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Playfair Display",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${snapshot.data!.docs[index]['parentphonenumber'].toString()}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Source Serif Pro",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height / 150,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "child name:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Playfair Display",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${snapshot.data!.docs[index]['parentchildname'].toString()}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Source Serif Pro",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
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
