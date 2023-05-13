import 'package:bustrackingapp/view/school_admin/drawer/admindrawerwidget.dart';
import 'package:bustrackingapp/view_model/admin/admin_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  dynamic admin_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admin_viewmodel = Provider.of<Admin_viewmodel>(context, listen: false);
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
          "Admin",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFF76a6f0),
        elevation: 0,
      ),
      body: Stack(
        children: [
//layer 1

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

          //layer2
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "List of all school",
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "add_school");
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(child: Text("add school")),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("main")
                      .doc("main_document")
                      .collection("institute_list")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        child: Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                background: Container(
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
                                confirmDismiss: (direction) {
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
                                },
                                onDismissed:
                                    (DismissDirection direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    //logic to delete
                                    // bool result =
                                    //     await schooladmin_driver_viewmodel
                                    //         .delete_driver(context,
                                    //             snapshot.data!.docs[index].id);

                                    bool result =
                                        await admin_viewmodel.delete_school(
                                            context,
                                            snapshot.data!.docs[index].id);

                                    if (result) {
                                      Fluttertoast.showToast(
                                          msg: "Institute is Deleted");
                                    }
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                                    child: Container(
                                        margin: EdgeInsets.all(3),
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 207, 202, 202),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              (index + 1).toString() + ")",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "${snapshot.data!.docs[index].get("institute_name")}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
