import 'package:bustrackingapp/respository/schooladmin/schooladmin_bus_repo.dart';
import 'package:bustrackingapp/respository/schooladmin/schooladmin_parent_repo.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_parent_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schooladmin_bus_viewmodel extends ChangeNotifier {
  Schooladmin_bus_repo schooladmin_bus_repo = Schooladmin_bus_repo();
  dynamic schooladmin_loginscreen_viewmodel = null;

  String? busnum;

  Future<bool> add_bus(context) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    String institutename = schooladmin_loginscreen_viewmodel.institutename;

    return await schooladmin_bus_repo.add_bus(institutename, busnum);
  }
}
