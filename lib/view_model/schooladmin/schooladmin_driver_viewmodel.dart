import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schooladmin_driver_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  dynamic schooladmin_loginscreen_viewmodel = null;

  String? institute_doc_id;
  String? bus_doc_u_id;
  String? bus_num;
  String? drivername;
  String? driverphonenumber;
  String? driverpassword;
  String? confirmdriverpassword;

  List<DropdownMenuItem<String>> listof_bus_dropdown = [];

  List<DropdownMenuItem<String>> get_listof_bus_dropdown() {
    return listof_bus_dropdown;
  }

//
  Future<void> read_data_and_fill_list_of_bus_dropdown(context) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    // QuerySnapshot mm = await firebase.collection("drivers").get();
    listof_bus_dropdown.clear();
    QuerySnapshot mm = await schooladmin_firestore_service
        .get_buses_snapshot(schooladmin_loginscreen_viewmodel.institute_doc_id);

    mm.docs.forEach((doc) {
      if (doc["assigned"] == false) {
        listof_bus_dropdown.add(DropdownMenuItem(
          key: Key(doc.id.toString()),
          value: doc["busnum"].toString(),
          child: Text("${doc["busnum"].toString()}"),
        ));
      }
    });
    notifyListeners();
  }

  Future<bool> add_driver(context) async {
//use this only for getting institute name ....
    final schooladmin_login_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    institute_doc_id = schooladmin_login_viewmodel.institute_doc_id;
    return await schooladmin_firestore_service.add_driver(
      institute_doc_id,
      bus_doc_u_id,
      bus_num,
      drivername,
      driverphonenumber,
      confirmdriverpassword,
    );
  }
}
