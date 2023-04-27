import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schooladmin_parent_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  String? institute_doc_id;
  String? selectedbusnum;
  String? parentname;
  String? parentphonenumber;
  String? parentchildname;
  String? parentpassword;
  String? confirmparentpassword;
  String? letitude;
  String? longitude;
  

  Future<bool> add_parent(context) async {
//use this only for getting institute name ....
    final schooladmin_login_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    institute_doc_id = schooladmin_login_viewmodel.institute_doc_id;

    return await schooladmin_firestore_service.add_parent(institute_doc_id,
        parentname, parentphonenumber, parentchildname, confirmparentpassword,letitude,longitude);
  }
}
