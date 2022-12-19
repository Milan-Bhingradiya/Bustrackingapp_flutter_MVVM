import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admindrawerwidget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: admindrawer(),
      appBar: AppBar(
        title: Text("All Parents of our school"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.man,
                  size: 30,
                ),
                SizedBox(
                  width: 180,
                ),
                GestureDetector(
                  child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 80,
                      color: Colors.green,
                      child: Text("ADD")),
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
                                    "ADD parents",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Enter parents name"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        parentname = value;
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
                                              "Enter parent phone number"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        parentphonenumber = value;
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
                                              "Enter parent child number"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter value";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        parentchildname = value;
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
                                        password1 = value;
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

                                        if (password1 != password2) {
                                          return "password mismatch";
                                        }
                                        if (password1 == password2) {
                                          finalpassword = password2;
                                        }
                                      },
                                      onChanged: ((value) {
                                        password2 = value;
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
                                              .collection('parents')
                                              .doc(parentname)
                                              .set({
                                            'parentname': parentname,
                                            'parentphonenumber':
                                                parentphonenumber,
                                            'password': finalpassword,
                                            'parentchildname': parentchildname,
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('parents').snapshots(),
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
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]['parentname']
                              .toString()),
                          subtitle: Text(snapshot
                              .data!.docs[index]['parentphonenumber']
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
