import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schooladmin_homescreen_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  dynamic schooladmin_loginscreen_viewmodel = null;

  int? num_of_buses;
  int? num_of_parents;
  int? num_of_drivers;

  void set_num_of_buses(int x) {
    num_of_buses = x;
    notifyListeners();
  }

  void set_num_of_parents(int x) {
    num_of_parents = x;
    
    notifyListeners();
  }

  void set_num_of_drivers(int x) {
    num_of_drivers = x;
    
    notifyListeners();
  }

  void set_num_of_bus_parent_driver(context) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    String institute_doc_id =
        schooladmin_loginscreen_viewmodel.institute_doc_id;

    set_num_of_buses(
        await schooladmin_firestore_service.num_of_bus(institute_doc_id));
    set_num_of_parents(
        await schooladmin_firestore_service.num_of_driver(institute_doc_id));
    set_num_of_drivers(
        await schooladmin_firestore_service.num_of_parent(institute_doc_id));
  }
}
