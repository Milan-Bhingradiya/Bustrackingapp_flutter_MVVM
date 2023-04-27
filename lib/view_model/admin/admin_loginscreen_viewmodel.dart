import 'package:bustrackingapp/services/network_services/admin_services/admin_firestore_service.dart';

import 'package:flutter/material.dart';

class Admin_loginscreen_viewmodel with ChangeNotifier {
    Admin_firestore_service admin_firestore_service = Admin_firestore_service();


  String? id;
  String? password;

  Future<bool> check_admin_authenticity() async {
    String adminpassword = await admin_firestore_service.get_admin_password();

    print(adminpassword);
    print(adminpassword);
    print(password);

    if (id == "admin" && password == adminpassword) {
      return true;
    } else {
      return false;
    }
  }
}
