import 'dart:io' as io;

import 'package:bustrackingapp/services/network_services/parent_services/parent_firebasestorage_service.dart';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/model/parent/profile/parentlocation_model.dart';

import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Parent_profilescreen_viewmodel extends ChangeNotifier {
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();

  Parent_firebasestorage_service parent_firebasestorage_service =
      Parent_firebasestorage_service();

  String new_parentchildname = "";
  String new_parentphonenumber = "";
  String new_parentname = "";
  double? new_parentlat;
  double? new_parentlong;

  String? institute_doc_u_id;
  String? parent_doc_u_id;
  String? parentname;

  String? selected_profileimg_path;

  //for first time user showing img
  String? profile_img_downloadlink;

  //after profileupdate new link for update to database
  String? new_profile_img_downloadlink;

//
  Future<void> get_parent_data_and_fill_in_textfield(
      context,
      childnamecontroller,
      phonenumbercontroller,
      parentnamecontroller,
      parentletitudecontroller,
      parentlongitudecontroller) async {
    final parent_login_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);

//first:we geting data of driver
//get value from loginscreen viewwmodel
    institute_doc_u_id = parent_login_viewmodel.institute_doc_u_id.toString();
    parent_doc_u_id = parent_login_viewmodel.parent_doc_u_id;

    print("qqqqqqqqqqq ${institute_doc_u_id}");

    print("qqqqqqqqqqq ${parent_doc_u_id}");

    ///
    final DocumentSnapshot parentdata = await parent_firestore_service
        .get_parent_doc(institute_doc_u_id, parent_doc_u_id);

    // give data to cntrollers....
    if (parentdata.exists) {
      print("yes parent document exist");

      //
      childnamecontroller.text = parentdata['parentchildname'].toString();
      new_parentchildname = parentdata['parentchildname'].toString();

      phonenumbercontroller.text = parentdata['parentphonenumber'].toString();
      new_parentphonenumber = parentdata['parentphonenumber'].toString();

      parentnamecontroller.text = parentdata['parentname'].toString();
      new_parentname = parentdata['parentname'].toString();

      parentletitudecontroller.text = parentdata['letitude'].toString();
      new_parentlat = parentdata['letitude'];

      parentlongitudecontroller.text = parentdata['longitude'].toString();
      new_parentlong = parentdata['longitude'];

      try {
        profile_img_downloadlink = parentdata["profile_img_link"];
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "User have no profile picture");
      }
    }
  }

//set current location
  Future<bool> ask_for_loctaion_permission() async {
    return await parent_firestore_service.ask_for_loctaion_permission();
  }

  Future<void> set_current_location(
      parentletitudecontroller, parentlongitudecontroller) async {
    parentlocation_model locationdata =
        await parent_firestore_service.set_current_location();

    new_parentlat = locationdata.letitude;
    new_parentlong = locationdata.longitude;

    //for showing in diaplay
    parentletitudecontroller.text = new_parentlat.toString();
    parentlongitudecontroller.text = new_parentlong.toString();
  }

  // profile upload

  Future<bool> upload_profile() async {
    if (selected_profileimg_path == null || selected_profileimg_path == "") {
      //means not selected img
    } else {
      print("start uploading parent profile");
      await upload_pic_and_save_downloadlink();
      // after upload img this function set variable->  new_profile_img_downloadlink
    }

    bool updated_or_failed = false;

    updated_or_failed = await parent_firestore_service.parent_profile_upload(
        institute_doc_u_id,
        // parentname,
        new_parentname,
        new_parentchildname,
        new_parentphonenumber,
        new_parentlat,
        new_parentlong,
        // here if new img upload succefully and we get that uploaded img link then we upload
        // "new_profile_img_downloadlink" other wise we have to upload old link of profile img "profile_img_downloadlink"
        (new_profile_img_downloadlink == null ||
                new_profile_img_downloadlink == "")
            ? profile_img_downloadlink
            : new_profile_img_downloadlink,
        parent_doc_u_id);

    print("profile upoad status :;;; $updated_or_failed");
    return updated_or_failed;
  }

  Future<void> select_img() async {
    selected_profileimg_path =
        await parent_firebasestorage_service.pick_img_and_returnpath();
  }

  Future<void> upload_pic_and_save_downloadlink() async {
    if (selected_profileimg_path == "" || selected_profileimg_path == null) {
      //this mean imh is not selected
      print("for upload img u not selected any img");
    } else {
      io.File img_to_file = io.File(selected_profileimg_path.toString());

      try {
        // String id = "${new_parentname}_${new_parentphonenumber}";
        final ref = await FirebaseStorage.instance.ref().child(
            "bustrackingapp/$institute_doc_u_id/parent/$parent_doc_u_id");

        var uploadTask = ref.putFile(img_to_file);
        final snapshot = await uploadTask.whenComplete(() {});
        new_profile_img_downloadlink = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("error while trying to upload pic $e");
      }
    }
  }
}
