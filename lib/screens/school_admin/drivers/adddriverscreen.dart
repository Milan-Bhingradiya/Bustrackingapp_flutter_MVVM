import 'package:bustrackingapp/providers/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class adddriverscreen extends StatefulWidget {
  const adddriverscreen({super.key});

  @override
  State<adddriverscreen> createState() => _adddriverscreenState();
}

class _adddriverscreenState extends State<adddriverscreen> {
  final firebase = FirebaseFirestore.instance;

  TextEditingController selectbus_contoller = new TextEditingController();

  late String drivername;

  late String driverphonenumber;

  late String driverpassword1;
  late String driverpassword2;
  late String confirmdriverpassword;

  bool checkconfirmpassword = false;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late String institute_name;

  List<DropdownMenuItem> listof_bus_dropdown = [];
  String dropdownvalue = "";
  bool onetimeexecuted = false;
  void readdata_and_fill_listofdriver_dropdown() async {
    if (onetimeexecuted == false) {
      // QuerySnapshot mm = await firebase.collection("drivers").get();
      QuerySnapshot mm = await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_name)
          .collection("buses")
          .get();

      mm.docs.forEach((doc) {
        listof_bus_dropdown.add(DropdownMenuItem(
          value: doc["busnum"].toString(),
          child: Text("${doc["busnum"].toString()}"),
        ));
      });
    }

    onetimeexecuted == true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    institute_name = Provider.of<Alldata>(context, listen: false)
        .selected_schholname_from_schhol_auth;
    readdata_and_fill_listofdriver_dropdown();
  }

  @override
  Widget build(BuildContext context) {
    print("build is called");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add driver"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
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
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Driver name",
                            counterText: '',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
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
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Driver phone number",
                            counterText: '',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
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
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter password",
                            counterText: '',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
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
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter confirm password",
                            counterText: '',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enter value";
                            }

                            if (driverpassword1 != driverpassword2) {
                              return "password mismatch";
                            }
                            if (driverpassword1 == driverpassword2) {
                              confirmdriverpassword = driverpassword2;
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Select Bus Number"),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextFormField(
                              controller: selectbus_contoller,
                              decoration: InputDecoration(
                                enabled: false,
                                counterText: '',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(
                                  Icons.person,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter value";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {},
                            ),
                          ),

                          DropdownButton(
                              // aya value 9 slect thay ane list ma 2 var 9 hoy etle error ave, milan  will in future...
                              value:
                                  dropdownvalue == "" || dropdownvalue == null
                                      ? null
                                      : dropdownvalue,
                              hint: Text("Select bus "),
                              items: listof_bus_dropdown,
                              onChanged: (value) {
                                setState(() {
                                  dropdownvalue = value;
                                  selectbus_contoller.text = dropdownvalue;
                                });
                              })

                          // SizedBox(
                          //   width: 30,
                          //   child: Expanded(
                          //     child: DropdownButton(
                          //       isExpanded: true,
                          //       //    style: TextStyle(),
                          //       value: dropdownvalue,
                          //       //hint: Text("Select bus Number"),
                          //       items: listof_bus_dropdown,
                          //       onChanged: (value) {
                          //         print(value);
                          //         setState(() {
                          //           dropdownvalue = value.toString();
                          //           selectbus_contoller.text = dropdownvalue;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            print("succesful");
                            try {
                              await FirebaseFirestore.instance
                                  .collection('main')
                                  .doc("main_document")
                                  .collection("institute_list")
                                  .doc(institute_name)
                                  .collection("drivers")
                                  .doc(drivername)
                                  .set({
                                'drivername': drivername,
                                'driverphonenumber': driverphonenumber,
                                'password': confirmdriverpassword,
                                'busnum': dropdownvalue,
                              }).then((value) {
                                Fluttertoast.showToast(msg: "new driver added");
                              });
                            } catch (e) {
                              print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
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
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
