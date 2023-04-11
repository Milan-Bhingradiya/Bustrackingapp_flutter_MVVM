import 'package:bustrackingapp/data/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schooladmin_driver_repo {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();

  Future<QuerySnapshot> get_buses_snapshot(institutename) async {
    return await schooladmin_firestore_service
        .get_buses_snapshot(institutename);
  }

  Future<bool> add_driver(institutename, busnum, drivername, driverphonenumber,
      confirmdriverpassword) async {
    return await schooladmin_firestore_service.add_driver(institutename, busnum,
        drivername, driverphonenumber, confirmdriverpassword);
  }
}
