import 'package:bustrackingapp/providers/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class addnewparents_screen extends StatefulWidget {
  const addnewparents_screen({super.key});

  @override
  State<addnewparents_screen> createState() => _addnewparents_screen();
}

class _addnewparents_screen extends State<addnewparents_screen> {
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
    print("build is called");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Parents"),
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
                        style: TextStyle(
                            fontFamily: "Playfair Display", fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter parents name",
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
                            parentname = value;
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
                            labelText: "Enter parent phone number",
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
                            parentphonenumber = value;
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
                            labelText: "Enter parent child number",
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
                            parentchildname = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
                            password1 = value;
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
                            labelText: "Enter confirm password",
                            counterText: '',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                                   .collection('main')
                    .doc("main_document")
                    .collection("institute_list")
                    .doc(institute_name).collection("parents")
                                  
                                  .doc(parentname)
                                  .set({
                                'parentname': parentname,
                                'parentphonenumber': parentphonenumber,
                                'password': finalpassword,
                                'parentchildname': parentchildname,
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
