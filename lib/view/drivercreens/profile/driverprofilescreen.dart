import 'package:bustrackingapp/view_model/driver/driver_profilescreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

import '../../../providers/provider.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class driverprofilescreen extends StatefulWidget {
  const driverprofilescreen({super.key});

  @override
  State<driverprofilescreen> createState() => _driverprofilescreenState();
}

class _driverprofilescreenState extends State<driverprofilescreen> {
  //inside inistate will give value here provider insatace not work because here context not avilable
  // in  future do here assign instace of profileviewmodel  but use get_it package.....
  dynamic driver_profilescreen_viewmodel = null;

  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$");

  final TextEditingController drivername_controller = TextEditingController();
  final TextEditingController driverphonenumber_controller =
      TextEditingController();
  final TextEditingController driveremail_controller = TextEditingController();

  bool taptochoose = false;

  bool textfield_enable = false;
  bool showing_picked_image = false;

  late String? errortext_drivernamefield = null;
  late String? errortext_driverphonenumberfield = null;
  late String? errortext_driveremailfield = null;

  String save_or_edit = "Edit";

  milanop() async {
    driver_profilescreen_viewmodel =
        await Provider.of<Driver_profilescreen_viewmodel>(context,
            listen: false);

    await driver_profilescreen_viewmodel.get_driver_data_and_fill_in_textfield(
        context,
        drivername_controller,
        driverphonenumber_controller,
        driveremail_controller);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    milanop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: (driver_profilescreen_viewmodel == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (driver_profilescreen_viewmodel.new_drivername == null ||
                    driver_profilescreen_viewmodel.new_drivername == "")
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              print("ontap called");
                              print(save_or_edit);
                              if (save_or_edit == "Save") {
                                print("ontap in side");

                                await driver_profilescreen_viewmodel
                                    .select_img();

                                if (driver_profilescreen_viewmodel
                                            .selected_profileimg_path ==
                                        null ||
                                    driver_profilescreen_viewmodel
                                            .selected_profileimg_path ==
                                        "") {
                                  showing_picked_image = false;
                                } else {
                                  print("showing_picked_image true kayru");
                                  showing_picked_image = true;
                                }
                                setState(() {});
                              }
                            },
                            child: Column(
                              children: [
                                Visibility(
                                  visible: !showing_picked_image,
                                  child: CircleAvatar(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      radius: 70,
                                      backgroundColor: Colors.grey[100],
                                      foregroundImage: (driver_profilescreen_viewmodel
                                                      .profile_img_downloadlink ==
                                                  null ||
                                              driver_profilescreen_viewmodel
                                                      .profile_img_downloadlink ==
                                                  "")
                                          ? null
                                          : NetworkImage(
                                              driver_profilescreen_viewmodel
                                                  .profile_img_downloadlink
                                                  .toString())),
                                ),
                                Visibility(
                                  visible: showing_picked_image,
                                  child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.grey[100],
                                      foregroundImage: (driver_profilescreen_viewmodel
                                                      .selected_profileimg_path ==
                                                  null ||
                                              driver_profilescreen_viewmodel
                                                      .selected_profileimg_path ==
                                                  "")
                                          ? null
                                          : FileImage(io.File(
                                              driver_profilescreen_viewmodel
                                                  .selected_profileimg_path
                                                  .toString()))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                              "WELCOME  ${driver_profilescreen_viewmodel.new_drivername.toString().toUpperCase()}  ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                              key: _formKey,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: taptochoose,
                                      child: Text("Tap To Choose"),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    drivername_textfield(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    driverphonenumber_textfield(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    driveremail_textfield(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    button_edit_or_save()
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ));
  }

  Widget drivername_textfield() {
    return TextFormField(
      controller: drivername_controller,
      enabled: textfield_enable,
      decoration: InputDecoration(
        labelText: 'Name',
        errorText: errortext_drivernamefield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name is required';
        } else if (value.length < 3) {
          return 'Name must be at least 3 characters';
        } else {}
      },
      onChanged: (value) {
        driver_profilescreen_viewmodel.new_drivername = value;
        print(driver_profilescreen_viewmodel.new_drivername);
        print(errortext_drivernamefield);
      },
    );
  }

  Widget driverphonenumber_textfield() {
    return TextFormField(
      controller: driverphonenumber_controller,
      enabled: textfield_enable,
      decoration: InputDecoration(
        labelText: 'Phonenumber',
        errorText: errortext_driverphonenumberfield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phonenumber is required';
        } else if (value.length < 10) {
          return 'Enter valid number';
        } else {}
      },
      onChanged: (value) {
        driver_profilescreen_viewmodel.new_driverphonenumber = value;
      },
    );
  }

  Widget driveremail_textfield() {
    return TextFormField(
      controller: driveremail_controller,
      enabled: textfield_enable,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: errortext_driveremailfield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is required';
        } else if (!_emailRegex
            .hasMatch(driver_profilescreen_viewmodel.new_driveremail)) {
          return 'Enter valid email u miss something';
        } else {}
      },
      onChanged: (value) {
        driver_profilescreen_viewmodel.new_driveremail = value;
      },
    );
  }

  Widget button_edit_or_save() {
    return GestureDetector(
      onTap: () async {
        final FormState? form = _formKey.currentState;

        // if if_condition is true its is go to editmode..
        if (save_or_edit == "Edit") {
          setState(() {
            save_or_edit = "Save";
            textfield_enable = true;
            taptochoose = true;
          });
        }
        // if else is true it is go to again simple watch profile state
        else if (form!.validate()) {
          bool updated_or_failed =
              await driver_profilescreen_viewmodel.upload_profile();

          if (updated_or_failed) {
            Fluttertoast.showToast(
              msg: ' Profile Saved',
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          if (this.mounted) {
            setState(() {});
          }
          taptochoose = false;
          save_or_edit = "Edit";
          textfield_enable = false;
        }
        ;
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 40,
        width: 90,
        child: Center(child: Text(save_or_edit)),
      ),
    );
  }
}
