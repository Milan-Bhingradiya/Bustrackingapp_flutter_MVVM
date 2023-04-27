import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Schooladmin_firestore_service {
  //authentication page services...
  Future<DocumentSnapshot> get_given_institute_snapshot(
      institutedoc_u_id) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institutedoc_u_id.toString())
        .get();
    return doc;
  }

  //add bus page serviceses...
  Future<bool> add_bus(institute_doc_u_id, busnum) async {
    bool upadted_or_failed = false;
    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("buses")
        .doc()
        .set({"busnum": "${busnum.toString()}", "assigned": false}).then(
            (value) {
      upadted_or_failed = true;
    });
    return upadted_or_failed;
  }

  //for geeting all bus num taking snapshot of buses collection snapshot
  Future<QuerySnapshot> get_buses_snapshot(institute_doc_u_id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("buses")
        .get();
    return querySnapshot;
  }

//add driver
  Future<bool> add_driver(institute_doc_u_id, bus_doc_id, busnum, drivername,
      driverphonenumber, confirmdriverpassword) async {
    print("caal adddriver");
    bool upadted_or_failed = false;

    try {
      print("caal try");
      dynamic cc = await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_u_id.toString())
          .collection("buses")
          .doc(bus_doc_id.toString())
          .update({
        "assigned": true,
        "assigned_driver": drivername,
      }).then((value) async {
        print("insde secpmd");
        await FirebaseFirestore.instance
            .collection('main')
            .doc("main_document")
            .collection("institute_list")
            .doc(institute_doc_u_id)
            .collection("drivers")
            .doc()
            .set({
          'drivername': drivername,
          'driverphonenumber': driverphonenumber,
          'password': confirmdriverpassword,
          'busnum': busnum,
          // TODO: this is bydefault but ADD  school depo addres here for by default bus when creted location
          "letitude": 21.0123,
          "longitude": 71.0125,
        }).then((value) {
          upadted_or_failed = true;
        });
      });
      // print(cc);
    } catch (e) {
      print("error in schooladmin_firestore_sevice : $e");
    }
    if (upadted_or_failed) {
      return true;
    } else {
      return false;
    }
  }

//add driver
  Future<bool> add_parent(institute_doc_id, parentname, parentphonenumber,
      parentchildname, confirmparentpassword, letitude, longitude) async {
    print("caal adddriver");
    bool upadted_or_failed = false;
    try {
      await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_id.toString())
          .collection("parents")
          .doc()
          .set({
        'parentname': parentname,
        'parentphonenumber': parentphonenumber,
        'password': confirmparentpassword,
        'parentchildname': parentchildname,
        'letitude': double.parse(letitude),
        'longitude': double.parse(longitude),
      }).then((value) {
        upadted_or_failed = true;
      });
    } catch (e) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
      upadted_or_failed = true;
    } on Exception {
      print("zzzzzzzzzzzzzzzzzzzzzz");
    }
    ;
    if (upadted_or_failed) {
      return true;
    } else {
      return false;
    }
  }
}
