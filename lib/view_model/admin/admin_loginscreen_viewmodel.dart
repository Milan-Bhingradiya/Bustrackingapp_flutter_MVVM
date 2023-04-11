import 'package:bustrackingapp/respository/admin/admin_auth_repo.dart';
import 'package:flutter/material.dart';

class Admin_loginscreen_viewmodel with ChangeNotifier {
  Admin_auth_repo admin_addinstitute_repo = Admin_auth_repo();

  String? id;
  String? password;

  Future<bool> check_admin_authenticity() async {
    String adminpassword = await admin_addinstitute_repo.get_admin_password();

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
