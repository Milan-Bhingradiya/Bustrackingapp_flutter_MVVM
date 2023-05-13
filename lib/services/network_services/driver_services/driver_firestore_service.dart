import 'package:cloud_firestore/cloud_firestore.dart';

class Driver_firestore_service {
//loginpage
  // getting driver password from firebase for authenticate user
  Future<String?> get_password_of_driver_from_name(
      institute_doc_u_id, drivername) async {
    // final driverpassword;
    final querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("drivers")
        .where("drivername", isEqualTo: drivername)
        .get();

    if (querySnapshot == null ||
        querySnapshot.docs.length == 0 ||
        querySnapshot.size == 0) {
    } else if (querySnapshot.docs[0].exists) {
      Map<String, dynamic> data = await querySnapshot.docs[0].data();

      //print("servicesssss ${await data["password"]}");
      final password = await data["password"];

      return password;
    }
  }

  ///

  Future<String> get_driver_u_id_from_drivername(
      institute_u_id, drivername) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_u_id.toString())
        .collection("drivers")
        .where("drivername", isEqualTo: drivername)
        .get();

    return querySnapshot.docs[0].id.toString();
  }



//when user goto parent welcome screen  using phone number and otp method we neeed to find
// s=institute name and parent name from this phonenumber ..
//if we have institutename and parent name then we can easily call function for fil profile data

  Future<Map<String, String>>
      get_driver_institutename_id_and_driver_id_from_phonenumber(
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
          .collection("drivers")
          .where("driverphonenumber", isEqualTo: phonenumber)
          .get();

      if (all_matched_phonenumber_docs.size > 0) {
        institutename = institute_doc.id.toString();
        parentname = all_matched_phonenumber_docs.docs.first.id.toString();

        map = {
          "institute_id": institutename.toString(),
          "driver_id": parentname.toString()
        };
        break; // exit loop once a match is found
      }
    }

    if (map == null) {
      map = {"institute_id": "", "driver_id": ""};

      return map;
    } else {
      return map;
    }
  }


//profilepage services....

// get doc using instituteneme ,drivername, password
  Future<DocumentSnapshot> get_driver_doc(
      institute_doc_u_id, driver_doc_u_id) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(institute_doc_u_id)
        .collection("drivers")
        //TODO: arshil bhai ni jagya a variable avse
        .doc(driver_doc_u_id.toString())
        .get();
    return documentSnapshot;
  }

//get list of doc  using phone number..
//like this will return things inside collection
  Future<QuerySnapshot> get_driver_documentist_using_phonenumber(
      institute_doc_u_id, phonenumber) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id.toString())
        .collection("drivers")
        .where('driverphonenumber', isEqualTo: phonenumber)
        .limit(1)
        .get();
    return result;
  }

  Future<bool> driver_profile_upload(institute_doc_u_id, driver_u_id,
      new_drivername, new_driverphonenumber, profile_img_downloadlink
      // new_driveremail

      ) async {
    print(institute_doc_u_id);
    print(driver_u_id);

    bool check_update_or_not = false;
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
      // "email": new_driveremail.toString()
    }).then((value) {
      print("drive updateddddddddddddddddd");
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

   Future<bool> schooladmin_driver_profile_upload(institute_doc_u_id, driver_u_id,
      new_drivername, new_driverphonenumber,new_busnum, profile_img_downloadlink
      // new_driveremail

      ) async {
    print(institute_doc_u_id);
    print(driver_u_id);

    bool check_update_or_not = false;
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
      "busnum": new_busnum,
      // "email": new_driveremail.toString()
    }).then((value) {
      print("drive updateddddddddddddddddd");
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
      institute_doc_u_id) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_u_id)
        .collection("parents")
        .get();
    return result;
  }

  //

//select parent for chat screen services......................

  Future<QuerySnapshot> get_parent_documentist_of_given_institute_id(
      institutename_u_id) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institutename_u_id.toString())
        .collection("parents")
        .get();

    return result;
  }
  //////////////////////////
  ///
  ///

//// chating screen services.............

  Future<void> upload_chat_to_db(
      institute_doc_id,
      parent_doc_id,
      driver_doc_id,
      parent_chat_id,
      driver_chat_id,
      msg_data_sendtype,
      msg_data_receivetype) async {
// function aim  x
    // 1st task=>  here parent send msg to driver and we will save data inside parent/chat/parent_chat_id/sendedmsg(array) add...

    // and

    //2 task =>then save msg inside driver/chat/driver_chat_id/receivemsg(array add)....

//1
    DocumentSnapshot doc_snapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("drivers")
        .doc(driver_doc_id.toString())
        .collection("chat")
        .doc(driver_chat_id.toString())
        .get();

    if (doc_snapshot.exists) {
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
        "sended_messages": FieldValue.arrayUnion([msg_data_sendtype])
      });
    } else {
      //crate u_id for chat

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
        "sended_messages": FieldValue.arrayUnion([msg_data_sendtype])
      }).then((value) {
        print("msg uploaded to driver succefullyyyyyy");
      });
    }

    ////2
    DocumentSnapshot doc_snapshot2 = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .doc(institute_doc_id.toString())
        .collection("parents")
        .doc(parent_doc_id.toString())
        .collection("chat")
        .doc(parent_chat_id.toString())
        .get();

    if (doc_snapshot2.exists) {
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
        "received_messages": FieldValue.arrayUnion([msg_data_receivetype])
      });
    } else {
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
        "received_messages": FieldValue.arrayUnion([msg_data_receivetype])
      }).then((value) {
        print("msg uploaded to parent succefullyyyyyy");
      });
    }
  }
}
