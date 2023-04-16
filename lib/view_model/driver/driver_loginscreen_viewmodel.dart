import 'package:bustrackingapp/data/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/model/driver/auth/driver_enum.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Driver_loginscreen_viewmodel with ChangeNotifier {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();
  late String dropdownvalue;

  late String driver_selected_institute_at_driverlogin;
  late String driver_name_at_driverlogin;

//in this funcion call service.....
  Future<String?> get_driverpassword(dropdownvalue, drivername) async {
    print("viewmodel work");

    var a = await driver_firestore_service
        .get_password_of_driver_from_name(dropdownvalue, drivername)
        .then((value) {
      print(value);
    });
    print("mm $a");

    return a;
  }

  //check institite name,id,password is match with password with db password
  // then it will let user login and let him to second screen...

  Future<user_valid_or_invalid_or_emptyfiled> check_authenticity_of_user(
      institutename, name, password) async {
    var get_password_from_firebase;

    if (institutename == "" ||
        institutename == null ||
        name == null ||
        password == "") {
    } else {
      print("parent login getting password query fired");

      get_password_from_firebase = await driver_firestore_service
          .get_password_of_driver_from_name(institutename, name);
      print("password: $get_password_from_firebase");
    }

    //
    if (institutename == "" ||
        institutename == null ||
        password == null ||
        name == null) {
      print("some value is  null in driver login");

      return user_valid_or_invalid_or_emptyfiled.Empty;
    } else {
      if (get_password_from_firebase == password) {
        print("bhai hu aya  id and pass is true");
        driver_selected_institute_at_driverlogin = institutename;
        driver_name_at_driverlogin = name;
        return user_valid_or_invalid_or_emptyfiled.True;
      } else {
        return user_valid_or_invalid_or_emptyfiled.False;
      }
    }
  }

  void get_drivername_from_phonenumber(institutename, phonenumber) async {
    QuerySnapshot result = await driver_firestore_service
        .get_driver_documentist_using_phonenumber(institutename, phonenumber);

    driver_name_at_driverlogin = await result.docs.first.reference.id;
  }
}
