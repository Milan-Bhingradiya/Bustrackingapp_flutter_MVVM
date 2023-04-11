import 'package:bustrackingapp/data/network_services/driver_services/driver_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Driver_auth_repo {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

// getting password of driver from driver name and school name
//(school name is get from user selected drop down on ui)

  Future<String?> get_driver_password_from_firestore(
      dropdownvalue, drivername) async {
    var password = await driver_firestore_service
        .get_password_of_driver_from_name(dropdownvalue, drivername);

    return password.toString();
  }

  //
  Future<QuerySnapshot> get_driver_documentlist_using_phonenumber(
      institutename, phonenumber) async {
    final doc = await driver_firestore_service
        .get_driver_documentist_using_phonenumber(institutename, phonenumber);
    return doc;
  }
}
