import 'dart:async';

import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/screens/school_admin/parents/addnewparents_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  late String institute_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    institute_name = Provider.of<Alldata>(context, listen: false)
        .selected_schholname_from_schhol_auth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: admindrawer(),
      appBar: AppBar(
        title: Text("All Parents of our school"),
      ),
      body: Padding(
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => addnewparents_screen(),
                          ));
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
                    .doc(institute_name)
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
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 225, 222, 222),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['parentname']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      "  Mobile Num: ${snapshot.data!.docs[index]['parentphonenumber'].toString()}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      " child name: ${snapshot.data!.docs[index]['parentchildname'].toString()}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ],
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
    );
  }
}
