import 'package:bustrackingapp/model/parent/auth/parent_enum.dart';
import 'package:bustrackingapp/respository/parent/parent_auth_repo.dart';
import 'package:flutter/material.dart';

class Parent_loginscreen_viewmodel extends ChangeNotifier {
  String? verificationid_for_otp;
  String? parentphonenumber;

  String? parent_selected_institute_at_login;
  String? parent_entered_name_at_login;

  Parent_auth_repo parent_auth_repo = Parent_auth_repo();

  Future<user_valid_or_invalid_or_emptyfiled_in_parent>
      check_authenticity_of_user(institutename, parentname, password) async {
    var get_password_from_firebase;

    if (institutename == "" ||
        institutename == null ||
        parentname == null ||
        password == "") {
    } else {
      print("parent login getting password query fired");

      get_password_from_firebase = await parent_auth_repo
          .get_parent_password_from_firestore(institutename, parentname);
      print("password: $get_password_from_firebase");
    }

    //
    if (institutename == "" ||
        institutename == null ||
        password == null ||
        parentname == null) {
      print("some value is  null in driver login");

      return user_valid_or_invalid_or_emptyfiled_in_parent.Empty;
    } else {
      if (get_password_from_firebase == password) {
        print("bhai hu aya  id and pass is true");
        parent_selected_institute_at_login = institutename;
        parent_entered_name_at_login = parentname;

        print(
            "parent_selected_institute_at_login $parent_selected_institute_at_login");
        return user_valid_or_invalid_or_emptyfiled_in_parent.True;
      } else {
        return user_valid_or_invalid_or_emptyfiled_in_parent.False;
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////

  Future<bool> get_institutename_and_parentname_from_phonenumber(
      context) async {
    Map res = await parent_auth_repo
        .get_institutename_and_parentname_from_phonenumber(parentphonenumber);

    var institutename = res["institutename"];
    var parentname = res["parentname"];

    if (institutename == "" ||
        institutename == null ||
        parentname == "" ||
        parentname == null) {
      print("falsssssssssssssssssssssssssssssssssssssss");
      return false;
    } else {
      parent_selected_institute_at_login = institutename.toString();
      parent_entered_name_at_login = parentname.toString();
      print("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(institutename);
      print(parentname);
      return true;
    }
  }
}
