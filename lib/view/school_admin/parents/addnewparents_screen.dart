import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_parent_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class addnewparents_screen extends StatefulWidget {
  const addnewparents_screen({super.key});

  @override
  State<addnewparents_screen> createState() => _addnewparents_screen();
}

class _addnewparents_screen extends State<addnewparents_screen> {
  String? parentname;
  String? parentphonenumber;
  String? parentchildname;
  String? password1;
  String? password2;
  String? finalpassword;
  String? childname;
  String? drivername;

  bool show_loding = false;

  dynamic schooladmin_parent_viewmodel = null;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late String institute_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schooladmin_parent_viewmodel =
        Provider.of<Schooladmin_parent_viewmodel>(context, listen: false);
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
                      GestureDetector(
                        onTap: () async {
                          print("ontap called");

                          await schooladmin_parent_viewmodel
                              .pick_img_and_returnpath();

                          setState(() {});
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                                child: Text("Choose Profile"),
                                radius: 70,
                                backgroundColor: Colors.grey[100],
                                foregroundImage: (schooladmin_parent_viewmodel
                                                .selected_profileimg_path ==
                                            null ||
                                        schooladmin_parent_viewmodel
                                                .selected_profileimg_path ==
                                            "")
                                    ? null
                                    : FileImage(io.File(
                                        schooladmin_parent_viewmodel
                                            .selected_profileimg_path
                                            .toString()))),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_parent_name_textformfield(
                              schooladmin_parent_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_parent_phonenumber_textformfield(
                              schooladmin_parent_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_parent_childname_textformfield(
                              schooladmin_parent_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_parent_password_textformfield(
                              schooladmin_parent_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_parent_confirmpassword_textformfield(
                              schooladmin_parent_viewmodel)),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      const SizedBox(
                        height: 15,
                      ),
                      //  make left align below text in flutter
                      Padding(
                        padding:
                            EdgeInsets.all(8.0), // Add padding around the text
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pick up detail',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: enter_parent_letitude_textformfield(
                                schooladmin_parent_viewmodel),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(),
                          ),
                          Flexible(
                            flex: 10,
                            child: enter_parent_longitude_textformfield(
                                schooladmin_parent_viewmodel),
                          )
                        ],
                      ),
                      // DropdownButton(items: , onChanged: onChanged)
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              show_loding = true;
                            });

                            print("succesful");
                            bool updated_or_failed =
                                await schooladmin_parent_viewmodel
                                    .add_parent(context);

                            if (updated_or_failed) {
                              Fluttertoast.showToast(
                                  msg:
                                      "succesfully ${schooladmin_parent_viewmodel.parentname} is add");
                              Navigator.pop(context);
                            } else {}
                          } else {
                            Fluttertoast.showToast(msg: "unsuccesful to add");
                          }

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

Widget enter_parent_name_textformfield(schooladmin_parent_viewmodel) {
  return TextFormField(
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
      schooladmin_parent_viewmodel.parentname = value;
    },
  );
}

Widget enter_parent_phonenumber_textformfield(schooladmin_parent_viewmodel) {
  return TextFormField(
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
      schooladmin_parent_viewmodel.parentphonenumber = value;
    },
  );
}

Widget enter_parent_childname_textformfield(schooladmin_parent_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Enter child Name",
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
      schooladmin_parent_viewmodel.parentchildname = value;
    },
  );
}

Widget enter_parent_password_textformfield(schooladmin_parent_viewmodel) {
  return TextFormField(
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
      schooladmin_parent_viewmodel.parentpassword = value;
    },
  );
}

Widget enter_parent_confirmpassword_textformfield(
    schooladmin_parent_viewmodel) {
  return TextFormField(
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

      if (schooladmin_parent_viewmodel.parentpassword !=
          schooladmin_parent_viewmodel.confirmparentpassword) {
        return "password mismatch";
      }
      if (schooladmin_parent_viewmodel.parentpassword ==
          schooladmin_parent_viewmodel.confirmparentpassword) {}
    },
    onChanged: ((value) {
      schooladmin_parent_viewmodel.confirmparentpassword = value;
    }),
  );
}

Widget enter_parent_letitude_textformfield(schooladmin_parent_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "letitude",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    onChanged: ((value) {
      schooladmin_parent_viewmodel.letitude = value;
    }),
  );
}

Widget enter_parent_longitude_textformfield(schooladmin_parent_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "longitude",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    onChanged: ((value) {
      schooladmin_parent_viewmodel.longitude = value;
    }),
  );
}
