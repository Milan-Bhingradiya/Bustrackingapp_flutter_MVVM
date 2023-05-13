import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_parent_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_editparent_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_editparent_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/parent/schooladmin_parent_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class editparentscreen extends StatefulWidget {
  const editparentscreen({super.key});

  @override
  State<editparentscreen> createState() => _editparentscreenState();
}

class _editparentscreenState extends State<editparentscreen> {
  dynamic schooladmin_parent_viewmodel = null;
  dynamic schooladmin_editparent_viewmodel = null;

  bool showing_picked_image = false;

  String getSingleQuotedString(String input) {
    RegExp regExp = RegExp("'(.*?)'");
    RegExpMatch match = regExp.firstMatch(input)!;
    if (match != null) {
      return match.group(1)!;
    } else {
      return "";
    }
  }

  milanop() async {
    schooladmin_parent_viewmodel =
        Provider.of<Schooladmin_parent_viewmodel>(context, listen: false);
    schooladmin_editparent_viewmodel =
        Provider.of<Schooladmin_editparent_viewmodel>(context, listen: false);

    await schooladmin_editparent_viewmodel.get_parent_data(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    final size = MediaQuery.of(context).size;
    final schooladmin_editparent_viewmodel2 =
        Provider.of<Schooladmin_editparent_viewmodel>(context, listen: true);

    schooladmin_editparent_viewmodel2.new_parentname =
        schooladmin_editparent_viewmodel2.parentname;

    schooladmin_editparent_viewmodel2.new_parentphonenumber =
        schooladmin_editparent_viewmodel2.parentphonenumber;
    schooladmin_editparent_viewmodel2.new_parentchildname =
        schooladmin_editparent_viewmodel2.parentchildname;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 8,
                ),
                GestureDetector(
                  onLongPress: () async {
                    await schooladmin_editparent_viewmodel.select_img();
                    if (schooladmin_editparent_viewmodel2
                                .selected_profileimg_path ==
                            null ||
                        schooladmin_editparent_viewmodel2
                                .selected_profileimg_path ==
                            "") {
                      showing_picked_image = false;
                    } else {
                      print("showing_picked_image true kayru");
                      showing_picked_image = true;
                    }
                  },
                  child: Visibility(
                    visible: !showing_picked_image,
                    child: CircleAvatar(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                        radius: 70,
                        backgroundColor: Colors.grey[100],
                        foregroundImage: (schooladmin_editparent_viewmodel2
                                        .profile_img_downloadlink ==
                                    null ||
                                schooladmin_editparent_viewmodel2
                                        .profile_img_downloadlink ==
                                    "")
                            ? null
                            : NetworkImage(schooladmin_editparent_viewmodel2
                                .profile_img_downloadlink
                                .toString())),
                  ),
                ),
                Visibility(
                  visible: showing_picked_image,
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[100],
                      foregroundImage: (schooladmin_editparent_viewmodel2
                                      .selected_profileimg_path ==
                                  null ||
                              schooladmin_editparent_viewmodel2
                                      .selected_profileimg_path ==
                                  "")
                          ? null
                          : FileImage(io.File(schooladmin_editparent_viewmodel2
                              .selected_profileimg_path
                              .toString()))),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Tap on image for Update")),
                SizedBox(
                  height: size.height / 40,
                ),
                Container(
                  width: size.width / 1.2,
                  child: TextFormField(
                    controller:
                        schooladmin_editparent_viewmodel.parentname_controller,
                    decoration: InputDecoration(
                      labelText: 'Enter new name',
                      //errorText: "ghg",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Container(
                  width: size.width / 1.2,
                  child: TextFormField(
                    controller: schooladmin_editparent_viewmodel
                        .parentphonenumber_controller,
                    decoration: InputDecoration(
                      labelText: 'Enter new Mobilenumber',
                      errorText: null,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  SizedBox(
                  height: size.height / 40,
                ),
                Container(
                  width: size.width / 1.2,
                  child: TextFormField(
                    controller: schooladmin_editparent_viewmodel
                        .parentchildname_controller,
                    decoration: InputDecoration(
                      labelText: 'Enter new Mobilenumber',
                      errorText: null,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                GestureDetector(
                  onTap: () async {
                    schooladmin_editparent_viewmodel2.new_parentname =
                        schooladmin_editparent_viewmodel
                            .parentname_controller.text;
                    schooladmin_editparent_viewmodel2.new_parentphonenumber =
                        schooladmin_editparent_viewmodel
                            .parentphonenumber_controller.text;
                    try {
                      schooladmin_editparent_viewmodel2.new_parentchildname =
                          schooladmin_editparent_viewmodel
                              .parentphonenumber_controller.text;
                    } catch (e) {}
                    bool result = await schooladmin_editparent_viewmodel2
                        .upload_profile();

                    if (result) {
                      Fluttertoast.showToast(
                        msg: ' Profile Saved',
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      width: size.width / 1.2,
                      height: size.height / 13,
                      child: Center(
                        child: Text(
                          "SUbmit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
