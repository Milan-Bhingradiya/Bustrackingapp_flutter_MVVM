import 'package:cloud_firestore/cloud_firestore.dart';

class Driver_firestore_service {
//loginpage
  // getting driver password from firebase for authenticate user
  Future<String?> get_password_of_driver_from_name(
      dropdownvalue, drivername) async {
    // final driverpassword;
    final docSnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(dropdownvalue.toString())
        .collection("drivers")
        .doc(drivername.toString())
        .get();

    if (docSnapshot == null) {
    } else if (docSnapshot.exists) {
      Map<String, dynamic> data = await docSnapshot.data()!;

      //print("servicesssss ${await data["password"]}");
      final driverpassword = await data["password"];
      print("aaaaaaa $driverpassword");
      return driverpassword;
    }
  }

  //profilepage services....

// get doc using instituteneme ,drivername, password
  Future<DocumentSnapshot> get_driver_doc(institutename, drivername) async {
    final doc = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(institutename)
        .collection("drivers")
        //TODO: arshil bhai ni jagya a variable avse
        .doc(drivername)
        .get();
    return doc;
  }

  //get list of doc  using phone number..
  //like this will return things inside collection
  Future<QuerySnapshot> get_driver_documentist_using_phonenumber(
      institutename, phonenumber) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename)
        .collection("drivers")
        .where('driverphonenumber', isEqualTo: phonenumber)
        .limit(1)
        .get();
    return result;
  }

  Future<bool> driver_profile_upload(institutename, drivername, new_drivername,
      new_driverphonenumber, new_driveremail) async {
    bool check_update_or_not = false;
    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(institutename)
        .collection("drivers")
        //TODO: arshil bhai ni jagya a variable avse
        .doc(drivername)
        .update({
      "drivername": new_drivername.toString(),
      "driverphonenumber": new_driverphonenumber.toString(),
      "email": new_driveremail.toString()
    }).then((value) {
      check_update_or_not = true;
    }).catchError((error) {
      // Handle any errors
      print(error);
      check_update_or_not = false;
    });

    if (check_update_or_not == true) {
      return true;
    } else {
      return false;
    }
  }

  //this services for drivr show map
//  here i want all parent of pertiucar given institute from firestore so here i take querysnapshot(collection no photo..)
  Future<QuerySnapshot> get_parent_documentist_of_given_institutename(
      institutename) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename)
        .collection("parents")
        .get();
    return result;
  }
}
