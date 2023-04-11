import 'package:bustrackingapp/respository/schooladmin/schooladmin_auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Schooladmin_loginscreen_viewmodel extends ChangeNotifier {
  String? institutename;

  Schooladmin_auth_repo schooladmin_auth_repo = Schooladmin_auth_repo();

  Future<bool> check_authenticity_of_user(
      institutename_parameter, passwordcontroller) async {
    DocumentSnapshot doc = await schooladmin_auth_repo
        .get_given_institute_snapshot(institutename_parameter);

    if (doc["password"] == passwordcontroller.text) {
      institutename = institutename_parameter;
      print("done $institutename");
      return true;
    } else {
      return false;
    }
  }
}
