import 'package:bustrackingapp/data/network_services/driver_services/driver_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Driver_profile_repo {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

  Future<DocumentSnapshot>
      get_driver_document_using_drivername_and_institutename(
          institutename, drivername) async {
    final doc = await driver_firestore_service.get_driver_doc(
        institutename, drivername);
    return doc;
  }

  Future<bool> upload_driver_profile(institutename, drivername, new_drivername,
      new_driverphonenumber, new_driveremail) async {
    bool updated_or_failed =
        await driver_firestore_service.driver_profile_upload(institutename,
            drivername, new_drivername, new_driverphonenumber, new_driveremail);
    return updated_or_failed;
  }
}
