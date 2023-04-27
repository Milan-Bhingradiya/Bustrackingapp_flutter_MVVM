import 'package:bustrackingapp/model/parent/profile/parentlocation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Parent_firestore_service {
//loginscreen------
  Future<String?> get_password_of_parent_from_document(u_id, parentname) async {
    // final driverpassword;
    final querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(u_id.toString())
        .collection("parents")
        .where("parentname", isEqualTo: parentname)
        .get();

    if (querySnapshot == null ||
        querySnapshot.docs.length == 0 ||
        querySnapshot.size == 0) {
    } else if (querySnapshot.docs[0].exists) {
      Map<String, dynamic> data = await querySnapshot.docs[0].data();

      //print("servicesssss ${await data["password"]}");
      final password = await data["password"];
      print("aaaaaaa $password");
      return password;
    }
  }

//////
  Future<String> get_parent_u_id_from_parentname(
      institute_u_id, parentname) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_u_id.toString())
        .collection("parents")
        .where("parentname", isEqualTo: parentname)
        .get();

    return querySnapshot.docs[0].id.toString();
  }

  /////-----------
  //profilepage services....

// get doc using instituteneme ,drivername, password
  Future<DocumentSnapshot> get_parent_doc(
      institute_doc_u_id, parent_doc_u_id) async {
    print("inside get parent doc");

    final documentSnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(institute_doc_u_id.toString())
        .collection("parents")
        //TODO: arshil bhai ni jagya a variable avḍse
        .doc(parent_doc_u_id.toString())
        .get();
    return documentSnapshot;
  }

/////

  Future<bool> parent_profile_upload(
      u_id,
      parentname,
      new_parentname,
      new_parentchildname,
      new_parentphonenumber,
      parentlat,
      parentlong,
      profile_img_downloadlink,
      parent_u_id) async {
    bool check_update_or_not = false;
    await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(u_id)
        .collection("parents")
        //TODO: arshil bhai ni jagya a variable avse
        .doc(parent_u_id.toString())
        .update({
      "parentname": new_parentname,
      "parentchildname": new_parentchildname,
      "parentphonenumber": new_parentphonenumber,
      'letitude': parentlat,
      'longitude': parentlong,
      "profile_img_link": profile_img_downloadlink,
    }).then((value) {
      check_update_or_not = true;
    }).catchError((error) {
      // Handle any errors
      print("inside service erorr is:;; $error");
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

  Future<QuerySnapshot> get_driver_collection_querysnapshot(u_id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(u_id.toString())
        .collection("drivers")
        .get();

    return querySnapshot;
  }

//when user goto parent welcome screen  using phone number and otp method we neeed to find
// s=institute name and parent name from this phonenumber ..
//if we have institutename and parent name then we can easily call function for fil profile data

  Future<Map<String, String>>
      get_parent_institutename_and_parentname_from_phonenumber(
          phonenumber) async {
    String? institutename;
    String? parentname;
    Map<String, String>? map;

    final all_institute = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .get();

    for (var institute_doc in all_institute.docs) {
      final all_matched_phonenumber_docs = await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc.id.toString())
          .collection("parents")
          .where("parentphonenumber", isEqualTo: phonenumber)
          .get();

      if (all_matched_phonenumber_docs.size > 0) {
        institutename = institute_doc.get("institute_name").toString();
        parentname = all_matched_phonenumber_docs.docs.first
            .get("parentname")
            .toString();

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

//select driver for chat screen services......................

  Future<QuerySnapshot> get_driver_documentist_of_given_institutename(
      institutename) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename)
        .collection("drivers")
        .get();

    return result;
  }

//// chating screen services.............

  Future<void> upload_chat_to_db(
      institute_doc_id,
      parent_doc_id,
      driver_doc_id,
      parent_chat_id,
      driver_chat_id,
      msg_data_sendtype,
      msg_data_receivetype) async {
// function aim
    // 1st task=>  here parent send msg to driver and we will save data inside parent/chat/parent_chat_id/sendedmsg(array) add...

    // and

    //2 task =>then save msg inside driver/chat/driver_chat_id/receivemsg(array add)....

//1
    DocumentSnapshot doc_snapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("parents")
        .doc(parent_doc_id.toString())
        .collection("chat")
        .doc(parent_chat_id.toString())
        .get();

    if (doc_snapshot.exists) {
      await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_id.toString())
          .collection("parents")
          .doc(parent_doc_id.toString())
          .collection("chat")
          .doc(parent_chat_id.toString())
          .update({
        "sended_messages": FieldValue.arrayUnion([msg_data_sendtype])
      });
    } else {
      //crate u_id for chat

      await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_id.toString())
          .collection("parents")
          .doc(parent_doc_id.toString())
          .collection("chat")
          .doc(parent_chat_id.toString())
          .set({
        "sended_messages": FieldValue.arrayUnion([msg_data_sendtype])
      }).then((value) {
        print("msg uploaded to parent succefullyyyyyy");
      });
    }


    ////2
     DocumentSnapshot doc_snapshot2 = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("drivers")
        .doc(driver_doc_id.toString())
        .collection("chat")
        .doc(driver_chat_id.toString())
        .get();

    if (doc_snapshot2.exists) {
      await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
       .doc(institute_doc_id.toString())
        .collection("drivers")
        .doc(driver_doc_id.toString())
        .collection("chat")
        .doc(driver_chat_id.toString())
          .update({
        "received_messages": FieldValue.arrayUnion([msg_data_receivetype])
      });
    } else {
 

      await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .doc(institute_doc_id.toString())
        .collection("drivers")
        .doc(driver_doc_id.toString())
        .collection("chat")
        .doc(driver_chat_id.toString())
          .set({
        "received_messages": FieldValue.arrayUnion([msg_data_receivetype])
      }).then((value) {
        print("msg uploaded to driver succefullyyyyyy");
      });
    }
  }
}
