import 'package:bustrackingapp/respository/admin/admin_addinstitute_repo.dart';
import 'package:flutter/material.dart';

class Admin_addinstitute_viewmodel with ChangeNotifier {
  Admin_addinstitute_repo admin_addinstitute_repo = Admin_addinstitute_repo();

  String? institutename;
  String? institutepassword;
  String? instituteconfirmpassword;

  Future<bool> add_institute() async {
    return await admin_addinstitute_repo.add_institute(
        institutename, institutepassword);
  }
}
