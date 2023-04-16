import 'package:bustrackingapp/data/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_parent_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schooladmin_bus_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  dynamic schooladmin_loginscreen_viewmodel = null;

  String? busnum;

  Future<bool> add_bus(context) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    String institutename = schooladmin_loginscreen_viewmodel.institutename;

    return await schooladmin_firestore_service.add_bus(institutename, busnum);
  }
}
