import 'package:bustrackingapp/data/network_services/parent_services/parent_firestore_service.dart';

class Parent_auth_repo {
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();

  Future<String?> get_parent_password_from_firestore(
      dropdownvalue, drivername) async {
    var password = await parent_firestore_service
        .get_password_of_parent_from_document(dropdownvalue, drivername);

    return password.toString();
  }
}
