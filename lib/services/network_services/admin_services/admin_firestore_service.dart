import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/hashing.dart';

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
        "institute_name": schoolname.toString(),
        "password": schoolpassword
      }).then((value) {
        upadted_or_failed = true;
      });
    } catch (e) {
      print(
          "hii inside schooladmin_firestore_service add school function error occur milan");
      upadted_or_failed = false;
    }

    return upadted_or_failed;
  }

  Future<bool> delete_school(institute_doc_u_id) async {
    print("call school delete");
    bool upadted_or_failed = false;

    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .delete()
        .then((value) {
      upadted_or_failed = true;
    });

    return upadted_or_failed;
  }
}
