import 'package:bustrackingapp/model/parent/profile/parentlocation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Parent_firestore_service {
//loginscreen------
  Future<String?> get_password_of_parent_from_document(
      dropdownvalue, parentname) async {
    // final driverpassword;
    final docSnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(dropdownvalue.toString())
        .collection("parents")
        .doc(parentname.toString())
        .get();

    if (docSnapshot == null) {
    } else if (docSnapshot.exists) {
      Map<String, dynamic> data = await docSnapshot.data()!;

      //print("servicesssss ${await data["password"]}");
      final password = await data["password"];
      print("aaaaaaa $password");
      return password;
    }
  }

  /////-----------
  //profilepage services....

// get doc using instituteneme ,drivername, password
  Future<DocumentSnapshot> get_parent_doc(institutename, parentname) async {
    final doc = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(institutename)
        .collection("parents")
        //TODO: arshil bhai ni jagya a variable avse
        .doc(parentname)
        .get();
    return doc;
  }

/////

  Future<bool> parent_profile_upload(institutename, parentname, new_parentname,
      new_parentchildname, new_parentphonenumber, parentlat, parentlong,profile_img_downloadlink) async {
    bool check_update_or_not = false;
    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(institutename)
        .collection("parents")
        //TODO: arshil bhai ni jagya a variable avse
        .doc(parentname)
        .update({
      "parentname": new_parentname,
      "parentchildname": new_parentchildname,
      "parentphonenumber": new_parentphonenumber,
      'letitude': parentlat,
      'longitude': parentlong,
      "profile_img_link":profile_img_downloadlink,
    }).then((value) {
      check_update_or_not = true;
    }).catchError((error) {
      // Handle any errors
      print("inside service erorr is:;; $error" );
      check_update_or_not = false;
    });

    if (check_update_or_not == true) {
      return true;
    } else {
      return false;
    }
  }

////

  Future<bool> ask_for_loctaion_permission() async {
    bool done_or_fail = false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
      done_or_fail = false;
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      done_or_fail = true;
    }

    if (done_or_fail) {
      return true;
    } else {
      return false;
    }
  }

  Future<parentlocation_model> set_current_location() async {
    double parentlat;
    double parentlong;

    Position parentlocation = await Geolocator.getCurrentPosition();

    parentlocation_model obj = parentlocation_model();
    obj.letitude = parentlocation.latitude;
    obj.longitude = parentlocation.longitude;

    // FirebaseFirestore.instance
    //     .collection('main')
    //     .doc("main_document")
    //     .collection("institute_list")
    //     .doc(institutename)
    //     .collection("parents")
    //     .doc(parentname)
    //     .update({
    //   'letitude': parentlat,
    //   'longitude': parentlong,
    // });

    return obj;
  }

// track screen servicesss...

//for gettinng all driver let long we neeed collection of driver so...

  Future<QuerySnapshot> get_driver_collection_querysnapshot(
      institutename) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename)
        .collection("drivers")
        .get();

    return querySnapshot;
  }

//when user goto parent welcome screen  using phone number and otp method we neeed to find
// s=institute name and parent name from this phonenumber ..
//if we have institutename and parent name then we can easily call function for fil profile data

  Future<Map<String, String>> get_parent_institutename_and_parentname_from_phonenumber(phonenumber) async {
    String? institutename; String? parentname;
    Map<String, String>? map;

    final all_institute = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .get();

    for (var institute_name_doc in all_institute.docs) {
      final all_matched_phonenumber_docs = await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_name_doc.id.toString())
          .collection("parents")
          .where("parentphonenumber", isEqualTo: phonenumber)
          .get();

      if (all_matched_phonenumber_docs.size > 0) {
        institutename = institute_name_doc.id.toString();
        parentname = all_matched_phonenumber_docs.docs.first.id.toString();

        map = {
          "institutename": institutename.toString(),
          "parentname": parentname.toString()
        };
        break; // exit loop once a match is found
      }
    }

    if (map == null) {
      map = {"institutename": "", "parentname": ""};

      return map;
    } else {
      return map;
    }

  }
}
