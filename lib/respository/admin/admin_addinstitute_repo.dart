import 'package:bustrackingapp/data/network_services/admin_services/admin_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin_addinstitute_repo {
  Admin_firestore_service admin_firestore_service = Admin_firestore_service();

  Future<bool> add_institute(intstitutename, institutepassword) async {
    return await admin_firestore_service.add_institute(
        intstitutename, institutepassword);
  }
}
