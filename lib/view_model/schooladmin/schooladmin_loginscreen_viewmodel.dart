import 'package:bustrackingapp/data/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Schooladmin_loginscreen_viewmodel extends ChangeNotifier {
  String? institutename;

   Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  Future<bool> check_authenticity_of_user(
      institutename_parameter, passwordcontroller) async {
    DocumentSnapshot doc = await schooladmin_firestore_service
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
