import 'package:bustrackingapp/data/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schooladmin_parent_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  String? institutename;
  String? selectedbusnum;
  String? parentname;
  String? parentphonenumber;
  String? parentchildname;
  String? parentpassword;
  String? confirmparentpassword;

  Future<bool> add_parent(context) async {
//use this only for getting institute name ....
    final schooladmin_login_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    institutename = schooladmin_login_viewmodel.institutename;

    return await schooladmin_firestore_service.add_parent(institutename,
        parentname, parentphonenumber, parentchildname, confirmparentpassword);
  }
}
