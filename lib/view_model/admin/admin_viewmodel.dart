import 'package:bustrackingapp/services/network_services/admin_services/admin_firestore_service.dart';

import 'package:flutter/material.dart';

class Admin_viewmodel with ChangeNotifier {
    Admin_firestore_service admin_firestore_service = Admin_firestore_service();


  String? id;
  String? password;

  Future<bool> check_admin_authenticity() async {
    String adminpassword = await admin_firestore_service.get_admin_password();

    if (id == "admin" && password == adminpassword) {
      return true;
    } else {
      return false;
    }
  }


  
  String? institutename;
  String? institutepassword;
  String? instituteconfirmpassword;

  Future<bool> add_institute() async {
    return await admin_firestore_service.add_institute(
        institutename, institutepassword);
  }

  
  Future<bool> delete_school(context,institute_doc_u_id) async {
   

//use this only for getting institute name ....
   
 
    
    return await admin_firestore_service.delete_school(
      institute_doc_u_id
     
    );
  }
}
