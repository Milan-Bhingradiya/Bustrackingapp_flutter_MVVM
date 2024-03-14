import 'package:bustrackingapp/services/network_services/admin_services/admin_firestore_service.dart';
import 'package:bustrackingapp/utils/hashing.dart';

import 'package:flutter/material.dart';

class Admin_addinstitute_viewmodel with ChangeNotifier {
  Admin_firestore_service admin_firestore_service = Admin_firestore_service();

  String? institutename;
  String? institutepassword;
  String? instituteconfirmpassword;

  Future<bool> add_institute() async {
    String password = hashPassword(institutepassword!);
    return await admin_firestore_service.add_institute(institutename, password);
  }
}
