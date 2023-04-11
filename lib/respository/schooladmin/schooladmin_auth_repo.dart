import 'package:bustrackingapp/data/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schooladmin_auth_repo {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();

  Future<DocumentSnapshot> get_given_institute_snapshot(intstitutename) async {
    return await schooladmin_firestore_service
        .get_given_institute_snapshot(intstitutename);
  }
}
