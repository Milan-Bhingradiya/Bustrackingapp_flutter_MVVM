import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/buses/addbus_screen.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_bus_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class listofbusscreen extends StatefulWidget {
  const listofbusscreen({super.key});

  @override
  State<listofbusscreen> createState() => _listofbusscreenState();
}

class _listofbusscreenState extends State<listofbusscreen> {
  dynamic schooladmin_loginscreen_viewmodel = null;
  dynamic schooladmin_bus_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);
    schooladmin_bus_viewmodel =
        Provider.of<Schooladmin_bus_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Add Bus",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFF76a6f0),
        elevation: 0,
      ),
      body: Stack(
        children: [
          //layer 1
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
          //stack layer2|| layer 2
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add new bus ",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return addbusscreen();
                            },
                          ));
                        },
                        child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                              child: Text("ADD",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            )),
                      )
                    ],
                  ),
                ),
              ),

              ////////////////////////////////////////////////////////////
              Expanded(
                child: StreamBuilder(
                    // stream:
                    //     FirebaseFirestore.instance.collection('buses').snapshots(),

                    stream: FirebaseFirestore.instance
                        .collection('main')
                        .doc("main_document")
                        .collection("institute_list")
                        .doc(schooladmin_loginscreen_viewmodel.institute_doc_id)
                        .collection("buses")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: const CircularProgressIndicator());
                      } else
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
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
                                if (direction == DismissDirection.startToEnd) {
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
                                                Navigator.of(context).pop(true);
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
                                                Navigator.of(context).pop(true);
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
                              onDismissed: (DismissDirection direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  //logic to delete
                                  bool result = await schooladmin_bus_viewmodel
                                      .delete_bus(context,
                                          snapshot.data!.docs[index]["busnum"]);
                                  if (result) {
                                    Fluttertoast.showToast(msg: "aaa");
                                  }
                                }

                                if (direction == DismissDirection.startToEnd) {
                                  print("haaaaaaaaa");
                                }
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Material(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    elevation: 10,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 234, 231, 231),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        height: size.height / 9,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/bus.png"),
                                            const Text(
                                              "Bus number : ",
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "${snapshot.data!.docs[index]["busnum"].toString()}",
                                              style:
                                                  const TextStyle(fontSize: 25),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
