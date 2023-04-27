import 'package:cloud_firestore/cloud_firestore.dart';

class Admin_firestore_service {
  Future<String> get_admin_password() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("admin")
        .doc("admin")
        .get();

    return await documentSnapshot.get("password");
  }

  Future<bool> add_institute(schoolname, schoolpassword) async {
    bool upadted_or_failed = false;

    try {
      await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc()
          .set({
            "institute_name" :schoolname.toString(),
            "password": schoolpassword.toString()}).then((value) {
        upadted_or_failed = true;
      });
    } catch (e) {
      print(
          "hii inside schooladmin_firestore_service add school function error occur milan");
      upadted_or_failed = false;
    }

    return upadted_or_failed;
  }
}
