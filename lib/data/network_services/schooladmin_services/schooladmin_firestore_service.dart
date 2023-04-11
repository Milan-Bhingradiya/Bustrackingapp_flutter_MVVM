import 'package:cloud_firestore/cloud_firestore.dart';

class Schooladmin_firestore_service {
  //authentication page services...
  Future<DocumentSnapshot> get_given_institute_snapshot(institutename) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename.toString())
        .get();
    return doc;
  }

  //add bus page serviceses...
  Future<bool> add_bus(institutename, busnum) async {
    bool upadted_or_failed = false;
    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename)
        .collection("buses")
        .doc(busnum.toString())
        .set({"busnum": "${busnum.toString()}", "assigned": false}).then(
            (value) {
      upadted_or_failed = true;
    });
    return upadted_or_failed;
  }

  //for geeting all bus num taking snapshot of buses collection snapshot
  Future<QuerySnapshot> get_buses_snapshot(institutename) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename.toString())
        .collection("buses")
        .get();
    return querySnapshot;
  }

//add driver
  Future<bool> add_driver(institutename, busnum, drivername, driverphonenumber,
      confirmdriverpassword) async {
    print("caal adddriver");
    bool upadted_or_failed = false;

    try {
      print("caal try");
      dynamic cc = await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institutename)
          .collection("buses")
          .doc(busnum.toString())
          .set({
        "assigned": true,
        "assigned_driver": drivername,
        "busnum": busnum.toString()
      }).then((value) async {
        print("insde secpmd");
        await FirebaseFirestore.instance
            .collection('main')
            .doc("main_document")
            .collection("institute_list")
            .doc(institutename)
            .collection("drivers")
            .doc(drivername)
            .set({
          'drivername': drivername,
          'driverphonenumber': driverphonenumber,
          'password': confirmdriverpassword,
          'busnum': busnum,
          // TODO: this is bydefault but ADD  school depo addres here for by default bus when creted location
          "letitude": 21.0,
          "longitude": 71.0,
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
  Future<bool> add_parent(institutename, parentname, parentphonenumber,
      parentchildname, confirmparentpassword) async {
    print("caal adddriver");
    bool upadted_or_failed = false;
    try {
      await FirebaseFirestore.instance
          .collection('main')
          .doc("main_document")
          .collection("institute_list")
          .doc(institutename)
          .collection("parents")
          .doc(parentname)
          .set({
        'parentname': parentname,
        'parentphonenumber': parentphonenumber,
        'password': confirmparentpassword,
        'parentchildname': parentchildname,
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
