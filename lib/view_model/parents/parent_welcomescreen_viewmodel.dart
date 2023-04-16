import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Parent_welcomescreen_viewmodel extends ChangeNotifier {
  void get_institutename_and_parentname_from_phonenumber(phonenumber) {
    FirebaseFirestore.instance
      ..collection("main")
          .doc("main_document")
          .collection("institute_list")
          .where("phonenumber",isEqualTo: "100");
  }
}
