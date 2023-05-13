import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:bustrackingapp/view_model/schooladmin/driver/schooladmin_driver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/driver/schooladmin_editdriver_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class editdriverscreen extends StatefulWidget {
  const editdriverscreen({super.key});

  @override
  State<editdriverscreen> createState() => _editdriverscreenState();
}

class _editdriverscreenState extends State<editdriverscreen> {
  List<DropdownMenuItem> listof_bus_dropdown = [];
  String? dropdownvalue = "";
  String? bus_doc_id;
  dynamic schooladmin_driver_viewmodel = null;
  dynamic schooladmin_editdriver_viewmodel = null;

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
    schooladmin_driver_viewmodel =
        Provider.of<Schooladmin_driver_viewmodel>(context, listen: false);
    schooladmin_editdriver_viewmodel =
        Provider.of<Schooladmin_editdriver_viewmodel>(context, listen: false);

    await schooladmin_driver_viewmodel
        .read_data_and_fill_list_of_bus_dropdown(context);

    await schooladmin_editdriver_viewmodel.get_driver_data(context);
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
    final schooladmin_editdriver_viewmodel2 =
        Provider.of<Schooladmin_editdriver_viewmodel>(context, listen: true);

    schooladmin_editdriver_viewmodel2.new_drivername =
        schooladmin_editdriver_viewmodel2.drivername;

    schooladmin_editdriver_viewmodel2.new_driverphonenumber =
        schooladmin_editdriver_viewmodel2.driverphonenumber;
    schooladmin_editdriver_viewmodel2.new_busnum =
        schooladmin_editdriver_viewmodel2.busnum;

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
                    await schooladmin_editdriver_viewmodel.select_img();
                    if (schooladmin_editdriver_viewmodel2
                                .selected_profileimg_path ==
                            null ||
                        schooladmin_editdriver_viewmodel2
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
                        foregroundImage: (schooladmin_editdriver_viewmodel2
                                        .profile_img_downloadlink ==
                                    null ||
                                schooladmin_editdriver_viewmodel2
                                        .profile_img_downloadlink ==
                                    "")
                            ? null
                            : NetworkImage(schooladmin_editdriver_viewmodel2
                                .profile_img_downloadlink
                                .toString())),
                  ),
                ),
                Visibility(
                  visible: showing_picked_image,
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[100],
                      foregroundImage: (schooladmin_editdriver_viewmodel2
                                      .selected_profileimg_path ==
                                  null ||
                              schooladmin_editdriver_viewmodel2
                                      .selected_profileimg_path ==
                                  "")
                          ? null
                          : FileImage(io.File(schooladmin_editdriver_viewmodel2
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
                        schooladmin_editdriver_viewmodel.drivername_controller,
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
                    controller: schooladmin_editdriver_viewmodel
                        .driverphonenumber_controller,
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
                  height: size.height / 11.5,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(2.0), //<-- SEE HERE
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width / 25,
                        ),
                        Text("Select New Bus"),
                        SizedBox(
                          width: size.width / 10,
                        ),
                        Container(
                          width: size.width / 4,
                          child: DropdownButton(
                              // aya value 9 slect thay ane list ma 2 var 9 hoy etle error ave, milan  will in future...
                              value:
                                  dropdownvalue == "" || dropdownvalue == null
                                      ? null
                                      : dropdownvalue,
                              hint: Text(schooladmin_editdriver_viewmodel
                                  .busnum_controller.text),
                              items: Provider.of<Schooladmin_driver_viewmodel>(
                                      context)
                                  .get_listof_bus_dropdown(),
                              onChanged: (value) {
                                print(dropdownvalue);
                                dropdownvalue = value;
                                schooladmin_driver_viewmodel.bus_doc_u_id =
                                    dropdownvalue;
                                print(dropdownvalue);

                                final bus_id =
                                    Provider.of<Schooladmin_driver_viewmodel>(
                                            context,
                                            listen: false)
                                        .listof_bus_dropdown
                                        .firstWhere(
                                            (item) => item.value == value)
                                        .key
                                        .toString();

                                bus_doc_id = getSingleQuotedString(bus_id);
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                GestureDetector(
                  onTap: () async {
                    schooladmin_editdriver_viewmodel2.new_drivername =
                        schooladmin_editdriver_viewmodel
                            .drivername_controller.text;
                    schooladmin_editdriver_viewmodel2.new_driverphonenumber =
                        schooladmin_editdriver_viewmodel
                            .driverphonenumber_controller.text;
                    try {
                      schooladmin_editdriver_viewmodel2.new_busnum =
                          int.parse(dropdownvalue.toString());
                    } catch (e) {}
                    bool result =
                        await schooladmin_editdriver_viewmodel2.edit_profile();

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
