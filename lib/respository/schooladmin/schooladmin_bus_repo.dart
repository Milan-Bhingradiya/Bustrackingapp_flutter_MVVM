import 'package:bustrackingapp/data/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schooladmin_bus_repo {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();

  Future<bool> add_bus(institutename, busnum) async {
    return await schooladmin_firestore_service.add_bus(institutename, busnum);
  }
}
