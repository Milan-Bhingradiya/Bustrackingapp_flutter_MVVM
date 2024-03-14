import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/schooladmin/driver/schooladmin_driver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class adddriverscreen extends StatefulWidget {
  const adddriverscreen({super.key});

  @override
  State<adddriverscreen> createState() => _adddriverscreenState();
}

class _adddriverscreenState extends State<adddriverscreen> {
  dynamic schooladmin_driver_viewmodel = null;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<DropdownMenuItem> listof_bus_dropdown = [];
  String? dropdownvalue = "";
  String? bus_doc_id;

  bool show_loding = false;

  String getSingleQuotedString(String input) {
    RegExp regExp = RegExp("'(.*?)'");
    RegExpMatch match = regExp.firstMatch(input)!;
    if (match != null) {
      return match.group(1)!;
    } else {
      return "";
    }
  }

  milanop() {
    schooladmin_driver_viewmodel =
        Provider.of<Schooladmin_driver_viewmodel>(context, listen: false);

    schooladmin_driver_viewmodel
        .read_data_and_fill_list_of_bus_dropdown(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    schooladmin_driver_viewmodel.selected_profileimg_path = "";
  }

  @override
  Widget build(BuildContext context) {
    print("build is called");
    print(listof_bus_dropdown.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add driver"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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

                              await schooladmin_driver_viewmodel
                                  .pick_img_and_returnpath();

                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                      child: Text("Choose Profile"),
                                      radius: 70,
                                      backgroundColor: Colors.grey[100],
                                      foregroundImage: (schooladmin_driver_viewmodel
                                                      .selected_profileimg_path ==
                                                  null ||
                                              schooladmin_driver_viewmodel
                                                      .selected_profileimg_path ==
                                                  "")
                                          ? null
                                          : FileImage(io.File(
                                              schooladmin_driver_viewmodel
                                                  .selected_profileimg_path
                                                  .toString()))),
                                ),
                              ],
                            ),
                          ),

                          ////////////
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: enter_driver_name_textformfield(
                                  schooladmin_driver_viewmodel)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: enter_driver_phonenumber_textformfield(
                                  schooladmin_driver_viewmodel)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: enter_driver_password_textformfield(
                                  schooladmin_driver_viewmodel)),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            color: Colors.amber,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: enter_driver_confirmpassword_textformfield(
                                  schooladmin_driver_viewmodel)),
                          SizedBox(
                            height: 35,
                          ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Select Bus"),
                              DropdownButton(
                                  // aya value 9 slect thay ane list ma 2 var 9 hoy etle error ave, milan  will in future...
                                  value: dropdownvalue == "" ||
                                          dropdownvalue == null
                                      ? null
                                      : dropdownvalue,
                                  hint: Text("Select bus "),
                                  items:
                                      Provider.of<Schooladmin_driver_viewmodel>(
                                              context)
                                          .get_listof_bus_dropdown(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownvalue = value;
                                      schooladmin_driver_viewmodel
                                          .bus_doc_u_id = dropdownvalue;

                                      final bus_id = Provider.of<
                                                  Schooladmin_driver_viewmodel>(
                                              context,
                                              listen: false)
                                          .listof_bus_dropdown
                                          .firstWhere(
                                              (item) => item.value == value)
                                          .key
                                          .toString();

                                      bus_doc_id =
                                          getSingleQuotedString(bus_id);
                                    });
                                  })
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
                                setState(() {
                                  show_loding = true;
                                });
                                try {
                                  schooladmin_driver_viewmodel.bus_doc_u_id =
                                      bus_doc_id;

                                  schooladmin_driver_viewmodel.bus_num =
                                      dropdownvalue;

                                  bool updated_or_fail =
                                      await schooladmin_driver_viewmodel
                                          .add_driver(context);

                                  if (updated_or_fail) {
                                    Fluttertoast.showToast(
                                        msg: "New Driver added");
                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
                                } on Exception {
                                  print("zzzzzzzzzzzzzzzzzzzzzz");
                                }
                                ;
                              } else {
                                print("unsuccesful");
                                Fluttertoast.showToast(
                                    msg: "unsuccesful to add");
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
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
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
          Visibility(
              visible: show_loding,
              child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}

Widget enter_driver_name_textformfield(schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "name",
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
      schooladmin_driver_viewmodel.drivername = value;
    },
  );
}

Widget enter_driver_phonenumber_textformfield(schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Phone number",
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
      schooladmin_driver_viewmodel.driverphonenumber = value;
    },
  );
}

Widget enter_driver_password_textformfield(schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "password",
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
      schooladmin_driver_viewmodel.driverpassword = value;
    },
  );
}

Widget enter_driver_confirmpassword_textformfield(
    schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "confirm password",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "enter value";
      }

      if (schooladmin_driver_viewmodel.driverpassword !=
          schooladmin_driver_viewmodel.confirmdriverpassword) {
        return "password mismatch";
      }
      if (schooladmin_driver_viewmodel.driverpassword ==
          schooladmin_driver_viewmodel.confirmdriverpassword) {}
    },
    onChanged: ((value) {
      schooladmin_driver_viewmodel.confirmdriverpassword = value;
    }),
  );
}
