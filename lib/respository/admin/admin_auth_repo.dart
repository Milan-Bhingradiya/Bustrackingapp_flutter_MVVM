import 'package:bustrackingapp/data/network_services/admin_services/admin_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin_auth_repo {
  Admin_firestore_service admin_firestore_service = Admin_firestore_service();

  Future<String> get_admin_password() async {
    return await admin_firestore_service.get_admin_password();
  }
}
