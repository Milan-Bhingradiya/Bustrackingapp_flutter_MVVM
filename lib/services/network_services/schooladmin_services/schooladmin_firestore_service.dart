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
        .set({"busnum": busnum, "assigned": false}).then((value) {
      upadted_or_failed = true;
    });
    return upadted_or_failed;
  }

  Future<bool> delete_bus(institute_doc_u_id, busnumber) async {
    print("call yes");
    bool upadted_or_failed = false;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("buses")
        .where("busnum", isEqualTo: busnumber)
        .get();
    print(querySnapshot.docs.length);
    if (querySnapshot.docs.isNotEmpty) {
      print("half");
      final docid = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_u_id.toString())
          .collection("buses")
          .doc(docid)
          .delete()
          .then((value) {
        upadted_or_failed = true;
      });
    } else {
      upadted_or_failed = false;
    }

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
  Future<bool> add_driver(
      institute_doc_u_id,
      bus_doc_id,
      busnum,
      drivername,
      driverphonenumber,
      confirmdriverpassword,
      profile_img_downloadlink,
      fcmtoken) async {
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
          'fcmtoken': fcmtoken,
          'drivername': drivername,
          'driverphonenumber': driverphonenumber,
          'password': confirmdriverpassword,
          'busnum': busnum,
          // TODO: this is bydefault but ADD  school depo addres here for by default bus when creted location
          "letitude": 21.0123,
          "longitude": 71.0125,
          "profile_img_link": profile_img_downloadlink
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

//edit in school admin

//for edit driver thi 2 func  use

  Future<String> get_bus_id_from_busnum(busnumber, institute_doc_id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("buses")
        .where("busnum", isEqualTo: busnumber)
        .get();

    return await querySnapshot.docs.first.id.toString();
  }

  Future<bool> driver_profile_edit(
      institute_doc_u_id,
      driver_u_id,
      new_drivername,
      new_driverphonenumber,
      old_busnum,
      new_busnum,
      new_busnum_id,
      profile_img_downloadlink) async {
    print(institute_doc_u_id);
    print(driver_u_id);

    bool check_update_or_not = false;

    print(old_busnum);
    print(new_busnum_id);

    try {
      await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_u_id.toString())
          .collection("buses")
          .doc(old_busnum.toString())
          .update({
        "assigned": false,
        "assigned_driver": "",
      }).then((value) => {
                FirebaseFirestore.instance
                    .collection('main')
                    .doc("main_document")
                    .collection("institute_list")
                    .doc(institute_doc_u_id.toString())
                    .collection("buses")
                    .doc(new_busnum_id.toString())
                    .update({
                  "assigned": true,
                  "assigned_driver": new_drivername,
                })
              });
    } catch (e) {
      print("add dlete bus lochc $e");
    }

    try {
      await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          //TODO: institute ma variable avse
          .doc(institute_doc_u_id)
          .collection("drivers")
          //TODO: arshil bhai ni jagya a variable avse
          .doc(driver_u_id.toString())
          .update({
        "drivername": new_drivername.toString(),
        "driverphonenumber": new_driverphonenumber.toString(),
        "profile_img_link": profile_img_downloadlink,
        "busnum": int.parse(new_busnum.toString()),
        // "email": new_driveremail.toString()
      }).then((value) {
        print("drive updateddddddddddddddddd");
        check_update_or_not = true;
      }).catchError((error) {
        // Handle any errors
        print(error);
        check_update_or_not = false;
      });
    } catch (e) {
      print(e);
    }

    if (check_update_or_not == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete_driver(institute_doc_u_id, driver_doc_id) async {
    print("call yes");
    bool upadted_or_failed = false;

    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("drivers")
        .doc(driver_doc_id.toString())
        .delete()
        .then((value) {
      upadted_or_failed = true;
    });

    return upadted_or_failed;
  }

//add driver
  Future<bool> add_parent(
      institute_doc_id,
      parentname,
      parentphonenumber,
      parentchildname,
      confirmparentpassword,
      letitude,
      longitude,
      profile_img_downloadlink,
      fcmtoken) async {
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
        'fcmtoken': fcmtoken,
        'parentname': parentname,
        'parentphonenumber': parentphonenumber,
        'password': confirmparentpassword,
        'parentchildname': parentchildname,
        'letitude': double.parse(letitude),
        'longitude': double.parse(longitude),
        "profile_img_link": profile_img_downloadlink
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

  Future<bool> delete_parent(institute_doc_u_id, parent_doc_id) async {
    print("call yes");
    bool upadted_or_failed = false;

    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("parents")
        .doc(parent_doc_id.toString())
        .delete()
        .then((value) {
      upadted_or_failed = true;
    });

    return upadted_or_failed;
  }

  //homescreen

  Future<int> num_of_bus(
    institute_doc_id,
  ) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("buses")
        .get();

    return querySnapshot.size;
  }

  Future<int> num_of_parent(
    institute_doc_id,
  ) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("parents")
        .get();

    return querySnapshot.size;
  }

  Future<int> num_of_driver(
    institute_doc_id,
  ) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("drivers")
        .get();

    return querySnapshot.size;
  }
}
