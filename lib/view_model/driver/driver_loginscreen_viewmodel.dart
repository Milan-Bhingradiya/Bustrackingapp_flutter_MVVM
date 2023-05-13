import 'package:bustrackingapp/services/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/model/driver/auth/driver_enum.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Driver_loginscreen_viewmodel with ChangeNotifier {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

  String? verificationid_for_otp;
   String? driverphonenumber;

  late String dropdownvalue;

  String? driver_name_at_driverlogin;
  String? institute_doc_u_id;
  String? driver_doc_u_id;

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
      institute_u_id1, name, password) async {
    var get_password_from_firebase;

    if (institute_u_id1 == "" ||
        institute_u_id1 == null ||
        name == null ||
        password == "") {
    } else {
      print("parent login getting password query fired");

      get_password_from_firebase = await driver_firestore_service
          .get_password_of_driver_from_name(institute_u_id1, name);
      print("password: $get_password_from_firebase");
    }

    //
    if (institute_u_id1 == "" ||
        institute_u_id1 == null ||
        password == null ||
        name == null) {
      print("some value is  null in driver login");

      return user_valid_or_invalid_or_emptyfiled.Empty;
    } else {
      if (get_password_from_firebase == password) {
        print("bhai hu aya  id and pass is true");
        institute_doc_u_id = institute_u_id1;
        driver_name_at_driverlogin = name;

        driver_doc_u_id =
            await driver_firestore_service.get_driver_u_id_from_drivername(
                institute_doc_u_id, driver_name_at_driverlogin);

        return user_valid_or_invalid_or_emptyfiled.True;
      } else {
        return user_valid_or_invalid_or_emptyfiled.False;
      }
    }
  }

  void get_drivername_from_phonenumber(institute_doc_uid1, phonenumber) async {
    QuerySnapshot result =
        await driver_firestore_service.get_driver_documentist_using_phonenumber(
            institute_doc_uid1, phonenumber);

    driver_name_at_driverlogin = await result.docs.first.reference.id;
  }


  
  Future<bool> get_institute_doc_u_id_and_driver_doc_u_id_from_phonenumber(
      context) async {
    Map res = await driver_firestore_service
        .get_driver_institutename_id_and_driver_id_from_phonenumber(
            driverphonenumber);

    var institute_doc_id = res["institute_id"];
    var driver_doc_id = res["driver_id"];

    if (institute_doc_id == "" ||
        institute_doc_id == null ||
        driver_doc_id == "" ||
        driver_doc_id == null) {
      print("falsssssssssssssssssssssssssssssssssssssss");
      return false;
    } else {
      institute_doc_u_id = institute_doc_id.toString();
      driver_name_at_driverlogin = driver_doc_id.toString();

      print("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(institute_doc_id);
     
      return true;
    }
  }
}
