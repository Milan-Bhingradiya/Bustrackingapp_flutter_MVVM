import 'package:bustrackingapp/respository/driver/driver_auth_repo.dart';
import 'package:bustrackingapp/respository/driver/driver_profile_repo.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Driver_profilescreen_viewmodel extends ChangeNotifier {
  final Driver_profile_repo driver_profile_repo = Driver_profile_repo();

  String new_drivername = "";
  String new_driverphonenumber = "";
  String new_driveremail = "";

  late String institutename;
  late String drivername;
  var x = "u";
  void milan() {}

//
  void get_driver_data_and_fill_in_textfield(context, drivername_controller,
      driverphonenumber_controller, driveremail_controller) async {
    final driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);

//first:we geting data of driver
//get value from loginscreen viewwmodel
    institutename = driver_login_viewmodel
        .driver_selected_institute_at_driverlogin
        .toString();
    drivername = driver_login_viewmodel.driver_name_at_driverlogin.toString();

    final DocumentSnapshot driverdata = await driver_profile_repo
        .get_driver_document_using_drivername_and_institutename(
            institutename, drivername);

    // give data to cntrollers....
    if (driverdata.exists) {
      print("yes driver document exist");
      drivername_controller.text = driverdata['drivername'].toString();
      driverphonenumber_controller.text =
          driverdata['driverphonenumber'].toString();
      driveremail_controller.text = driverdata['email'].toString();

      new_drivername = driverdata['drivername'].toString();
      new_driverphonenumber = driverdata['driverphonenumber'].toString();
      new_driveremail = driverdata['email'].toString();
    }
  }

  // profile upload
  Future<bool> upload_profile() async {
    bool updated_or_failed = await driver_profile_repo.upload_driver_profile(
        institutename,
        drivername,
        new_drivername,
        new_driverphonenumber,
        new_driveremail);
    print("aaa $updated_or_failed");
    return updated_or_failed;
  }
}