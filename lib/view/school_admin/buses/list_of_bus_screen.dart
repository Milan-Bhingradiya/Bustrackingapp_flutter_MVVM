import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/buses/addbus_screen.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class listofbusscreen extends StatefulWidget {
  const listofbusscreen({super.key});

  @override
  State<listofbusscreen> createState() => _listofbusscreenState();
}

class _listofbusscreenState extends State<listofbusscreen> {
  dynamic schooladmin_loginscreen_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("bus_list"),
      ),
      body: Column(
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
                    style: const TextStyle(fontSize: 20),
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
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                    .doc(schooladmin_loginscreen_viewmodel.institutename)
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
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Material(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                elevation: 10,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 234, 231, 231),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    height: 90,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/bus.png"),
                                        const Text(
                                          "Bus number : ",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "${snapshot.data!.docs[index]["busnum"]}",
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                }),
          )
        ],
      ),
    );
  }
}
