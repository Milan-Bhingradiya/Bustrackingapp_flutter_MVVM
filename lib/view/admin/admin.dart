import 'package:bustrackingapp/view/school_admin/drawer/admindrawerwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class admin extends StatelessWidget {
  const admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Column(
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
                          return Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: Container(
                                margin: EdgeInsets.all(3),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 207, 202, 202),
                                    borderRadius: BorderRadius.circular(5)),
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
                                      "${snapshot.data!.docs[index].id}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )),
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
    );
  }
}
