import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/parents/parent_profilescreen_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bustrackingapp/view/parentsscrens/drawer/parentdrawerwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class parentprofilescreen extends StatefulWidget {
  @override
  State<parentprofilescreen> createState() => _parentprofilescreenState();
}

class _parentprofilescreenState extends State<parentprofilescreen> {
  bool showing_picked_image = false;
  dynamic parent_profilescreen_viewmodel = null;

  String save_or_edit = "Edit";

  final TextEditingController childnamecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController parentnamecontroller = TextEditingController();

  final TextEditingController parentletitudecontroller =
      TextEditingController();

  final TextEditingController parentlongitudecontroller =
      TextEditingController();

  bool parent_textfield_enable = false;

  bool visible_set_location_button = false;
  bool taptochoose = false;

  void milanop() async {
    parent_profilescreen_viewmodel =
        await Provider.of<Parent_profilescreen_viewmodel>(context,
            listen: false);
//------------------------------
    await parent_profilescreen_viewmodel.get_parent_data_and_fill_in_textfield(
        context,
        childnamecontroller,
        phonenumbercontroller,
        parentnamecontroller,
        parentletitudecontroller,
        parentlongitudecontroller);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    milanop();
  }

  @override
  Widget build(BuildContext context) {
    print("builddddddddddddddd");
    return Scaffold(
        drawer: parentdrawer(),
        // appBar: AppBar(
        //   title: Text("edit profile"),
        //   backgroundColor: Color(0xFFc793ff),
        // ),
        body: (parent_profilescreen_viewmodel == null)
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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

                                await parent_profilescreen_viewmodel
                                    .select_img();

                                if (parent_profilescreen_viewmodel
                                            .selected_profileimg_path ==
                                        null ||
                                    parent_profilescreen_viewmodel
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
                                      foregroundImage: (parent_profilescreen_viewmodel
                                                      .profile_img_downloadlink ==
                                                  null ||
                                              parent_profilescreen_viewmodel
                                                      .profile_img_downloadlink ==
                                                  "")
                                          ? null
                                          : NetworkImage(
                                              parent_profilescreen_viewmodel
                                                  .profile_img_downloadlink
                                                  .toString())),
                                ),
                                Visibility(
                                  visible: showing_picked_image,
                                  child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.grey[100],
                                      foregroundImage: (parent_profilescreen_viewmodel
                                                      .selected_profileimg_path ==
                                                  null ||
                                              parent_profilescreen_viewmodel
                                                      .selected_profileimg_path ==
                                                  "")
                                          ? null
                                          : FileImage(io.File(
                                              parent_profilescreen_viewmodel
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
                              "WELCOME  ${parent_profilescreen_viewmodel.new_parentname.toString().toUpperCase()}  ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Visibility(
                            visible: taptochoose,
                            child: Text("Tap To Choose"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          parentname_textfield(),
                          SizedBox(
                            height: 15,
                          ),
                          parentchildname_textfield(),
                          SizedBox(
                            height: 15,
                          ),
                          parentphonenumber_textfield(),
                          SizedBox(
                            height: 15,
                          ),
                          parentletitude_textfield(),
                          SizedBox(
                            height: 15,
                          ),
                          parentlongitude_textfield(),
                          SizedBox(
                            height: 15,
                          ),
                          set_lat_long_button(),
                          SizedBox(
                            height: 15,
                          ),
                          parentbutton_edit_or_save()
                        ],
                      ),
                    ),
                  ),
                ),
              )
        // : Center(
        //     child: CircularProgressIndicator(),
        //   )
        );
  }

  Widget parentname_textfield() {
    return TextFormField(
      controller: parentnamecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Name',

        //  errorText: "name is not valid",
        // counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'name is required';
        } else {}
      },
      onChanged: (value) {
        parent_profilescreen_viewmodel.new_parentname = value;

        // if (new_parentname.isEmpty) {
        //   errortext_parentnamefield = 'Name is required';
        // } else if (new_parentname.length < 3) {
        //   errortext_parentnamefield = 'Name must be at least 3 characters';
        // } else {
        //   errortext_parentnamefield = null;
        // }
      },
    );
  }

  Widget parentchildname_textfield() {
    return TextFormField(
      autofocus: true,
      controller: childnamecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Child Name',

        //  errorText: "name is not valid",
        // counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'childname is required';
        } else {}
      },
      onChanged: (value) {
        parent_profilescreen_viewmodel.new_parentchildname = value;

        // if (new_parentchildname.isEmpty) {
        //   errortext_parentchildfield = 'Name is required';
        // } else if (new_parentchildname.length < 3) {
        //   errortext_parentchildfield = 'Name must be at least 3 characters';
        // } else {
        //   errortext_parentchildfield = null;
        // }
      },
    );
  }

  Widget parentphonenumber_textfield() {
    return TextFormField(
      controller: phonenumbercontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Phonenumber',

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
        parent_profilescreen_viewmodel.new_parentphonenumber = value;
        // if (new_parentphonenumber.isEmpty) {
        //   errortext_parentphonenumberfield = 'number is required';
        // } else if (new_parentphonenumber.length < 10) {
        //   errortext_parentphonenumberfield = 'Enter a valid number';
        // } else {
        //   errortext_parentphonenumberfield = null;
        // }
      },
    );
  }

  Widget parentletitude_textfield() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: parentletitudecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Pick Place letitude',

        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'letitude is required';
        } else {}
      },
      onChanged: (value) {
        parent_profilescreen_viewmodel.new_parentlat = double.parse(value);
        // if (parentlat == 0) {
        //   errortext_parentletitude = 'number is required';
        // } else {
        //   errortext_parentletitude = null;
        // }
      },
    );
  }

  Widget parentlongitude_textfield() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: parentlongitudecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Pick Place longitude',

        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'longitude is required';
        } else {}
      },
      onChanged: (value) {
        parent_profilescreen_viewmodel.new_parentlong = double.parse(value);
        // if (parentlong == 0) {
        //   errortext_parentlongitude = 'number is required';
        // } else {
        //   errortext_parentlongitude = null;
        // }
      },
    );
  }

  Widget set_lat_long_button() {
    return Visibility(
      visible: visible_set_location_button,
      child: GestureDetector(
        onTap: () async {
          print("set location call");
          bool got_permisiion = await parent_profilescreen_viewmodel
              .ask_for_loctaion_permission();

          print(got_permisiion);
          if (got_permisiion) {
            await parent_profilescreen_viewmodel.set_current_location(
                parentletitudecontroller, parentlongitudecontroller);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          alignment: Alignment.center,
          height: 40,
          width: 300,
          child: Text(
            "set my current location",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget parentbutton_edit_or_save() {
    return GestureDetector(
      onTap: () async {
        final FormState? form = _formKey.currentState;

        // if if_condition is true its is go to editmode..
        if (save_or_edit == "Edit") {
          setState(() {
            save_or_edit = "Save";
            parent_textfield_enable = true;
            visible_set_location_button = true;
            taptochoose = true;
          });
        }

        // if else is true it is go to again simple watch profile state
        else if (form!.validate()) {
          bool updated_or_failed =
              await parent_profilescreen_viewmodel.upload_profile();

          setState(() {
            taptochoose = false;
            save_or_edit = "Edit";
            parent_textfield_enable = false;
            visible_set_location_button = false;

////////////////////////////////////////////////

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
          });
        }

        print("touch");
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
