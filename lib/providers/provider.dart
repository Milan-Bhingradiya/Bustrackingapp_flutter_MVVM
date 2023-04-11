import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Alldata extends ChangeNotifier {
//////

  List<DropdownMenuItem> list_of_institute_dropdownitem = [];

  void fill_list_of_institute_dropdownitem() async {
    print("bbbbbbbbbbbbbbbbbbbbbbbbb");
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .get();
    list_of_institute_dropdownitem.clear();
    querysnapshot.docs.forEach((doc) {
      list_of_institute_dropdownitem.add(DropdownMenuItem(
          value: doc.id.toString(), child: Text(doc.id.toString())));
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
