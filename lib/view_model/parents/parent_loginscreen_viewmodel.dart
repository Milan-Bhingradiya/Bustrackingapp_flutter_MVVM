import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/model/parent/auth/parent_enum.dart';

import 'package:flutter/material.dart';

class Parent_loginscreen_viewmodel extends ChangeNotifier {
  String? verificationid_for_otp;
  String? parentphonenumber;

  // String? parent_selected_institute_at_login;
  String? institute_doc_u_id;
  String? parent_entered_name_at_login;
  String? parent_doc_u_id;
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();

  Future<user_valid_or_invalid_or_emptyfiled_in_parent>
      check_authenticity_of_user(u_id, parentname, password) async {
    var get_password_from_firebase;

    if (u_id == "" || u_id == null || parentname == null || password == "") {
    } else {
      print("parent login getting password query fired");

      get_password_from_firebase = await parent_firestore_service
          .get_password_of_parent_from_document(u_id, parentname);
      print("password: $get_password_from_firebase");
    }

    //
    if (u_id == "" || u_id == null || password == null || parentname == null) {
      print("some value is  null in driver login");

      return user_valid_or_invalid_or_emptyfiled_in_parent.Empty;
    } else {
      if (get_password_from_firebase == password) {
        print("bhai hu aya  id and pass is true");

        parent_entered_name_at_login = parentname;
        institute_doc_u_id = u_id;

       parent_doc_u_id= await parent_firestore_service.get_parent_u_id_from_parentname(institute_doc_u_id,parentname);
        //get parent u_id from name

        return user_valid_or_invalid_or_emptyfiled_in_parent.True;
      } else {
        return user_valid_or_invalid_or_emptyfiled_in_parent.False;
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////

  Future<bool> get_institute_doc_u_id_and_parentname_from_phonenumber(
      context) async {
    Map res = await parent_firestore_service
        .get_parent_institutename_and_parentname_from_phonenumber(
            parentphonenumber);

    var institute_doc_id = res["institutename"];
    var parentname = res["parentname"];

    if (institute_doc_id == "" ||
        institute_doc_id == null ||
        parentname == "" ||
        parentname == null) {
      print("falsssssssssssssssssssssssssssssssssssssss");
      return false;
    } else {
      institute_doc_u_id = institute_doc_id.toString();
      parent_entered_name_at_login = parentname.toString();

      print("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(institute_doc_id);
      print(parentname);
      return true;
    }
  }
}
