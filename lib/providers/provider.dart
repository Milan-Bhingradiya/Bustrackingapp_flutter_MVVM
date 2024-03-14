import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

// for hash
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Alldata extends ChangeNotifier {
//////

  List<DropdownMenuItem> list_of_institute_dropdownitem = [];
  QuerySnapshot? previousSnapshot;
  void fill_list_of_institute_dropdownitem() async {
    print("bbbbbbbbbbbbbbbbbbbbbbbbb");

    try {
      QuerySnapshot newSnapshot = await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .get();

      if (previousSnapshot == null ||
          _isDataChanged(previousSnapshot!, newSnapshot)) {
        print(_isDataChanged(previousSnapshot!, newSnapshot));
        list_of_institute_dropdownitem.clear();
        log('school list update.', name: 'MyApp');
        newSnapshot.docs.forEach((doc) {
          list_of_institute_dropdownitem.add(DropdownMenuItem(
              key: Key(doc.id.toString()),
              value: doc.get("institute_name").toString(),
              child: Text(doc.get("institute_name").toString())));
        });

        previousSnapshot = newSnapshot;
      }
    } catch (e) {
      print('Error fetching school: $e');
      print("error");
    }
  }

// -------------------------------------------------------------------------------------------------------------------
  bool _isDataChanged(QuerySnapshot oldSnapshot, QuerySnapshot newSnapshot) {
    // If either snapshot is null or the number of documents is different, data is considered changed
    if (oldSnapshot == null ||
        newSnapshot == null ||
        oldSnapshot.docs.length != newSnapshot.docs.length) {
      print("first true");
      return true;
    }

    // Compare each document and its fields
    for (int i = 0; i < oldSnapshot.docs.length; i++) {
      // Check if the document ID and data are equal
      if (oldSnapshot.docs[i].id != newSnapshot.docs[i].id) {
        return true; // Data is different
      }

      String oldInstituteName = oldSnapshot.docs[i].get('institute_name');
      String newInstituteName = newSnapshot.docs[i].get('institute_name');

      // Check if the "institute name" field is different
      if (oldInstituteName != newInstituteName) {
        return true; // Institute name is different
      }
    }

    return false; // Data is the same
  }

  // -------------------------------------------------------------------------------------------------------------------

}
