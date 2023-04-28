import 'package:bustrackingapp/services/network_services/driver_services/driver_firebasestorage_service.dart';
import 'package:bustrackingapp/services/network_services/driver_services/driver_firestore_service.dart';

import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class Driver_profilescreen_viewmodel extends ChangeNotifier {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

  Driver_firebasestorage_service driver_firebasestorage_service =
      Driver_firebasestorage_service();
  String new_drivername = "";
  String new_driverphonenumber = "";
  String new_driveremail = "";

  String? institute_doc_u_id;
  String? driver_doc_u_id;
  late String drivername;

  String? selected_profileimg_path;

  //for first time user showing img
  String? profile_img_downloadlink;

  //after profileupdate new link for update to database
  String? new_profile_img_downloadlink;
  var x = "u";
  void milan() {}

//
  void get_driver_data_and_fill_in_textfield(context, drivername_controller,
      driverphonenumber_controller, driveremail_controller) async {
    final driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);

//first:we geting data of driver
//get value from loginscreen viewwmodel
    institute_doc_u_id = driver_login_viewmodel.institute_doc_u_id.toString();
    driver_doc_u_id = driver_login_viewmodel.driver_doc_u_id.toString();

    final DocumentSnapshot driverdata = await driver_firestore_service
        .get_driver_doc(institute_doc_u_id, driver_doc_u_id);

    // give data to cntrollers....
    if (driverdata.exists) {
      print("yes driver document exist");
      drivername_controller.text = driverdata['drivername'].toString();
      driverphonenumber_controller.text =
          driverdata['driverphonenumber'].toString();
      //  driveremail_controller.text = driverdata['email'].toString();

      new_drivername = driverdata['drivername'].toString();
      new_driverphonenumber = driverdata['driverphonenumber'].toString();
      //  new_driveremail = driverdata['email'].toString();

      try {
        profile_img_downloadlink = driverdata["profile_img_link"];
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "User have no profile picture");
      }
    }
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

    bool updated_or_failed =
        await driver_firestore_service.driver_profile_upload(
      institute_doc_u_id,
      driver_doc_u_id,
      new_drivername,
      new_driverphonenumber,
      // new_driveremail,

      (new_profile_img_downloadlink == null ||
              new_profile_img_downloadlink == "")
          ? profile_img_downloadlink
          : new_profile_img_downloadlink,
    );

    print("aaa $updated_or_failed");
    return updated_or_failed;
  }

  Future<void> select_img() async {
    selected_profileimg_path =
        await driver_firebasestorage_service.pick_img_and_returnpath();
  }

  Future<void> upload_pic_and_save_downloadlink() async {
    if (selected_profileimg_path == "" || selected_profileimg_path == null) {
      //this mean imh is not selected
      print("for upload img u not selected any img");
    } else {
      io.File img_to_file = io.File(selected_profileimg_path.toString());

      try {
        // String id = "${new_drivername}_${new_driverphonenumber}";
        final ref = await FirebaseStorage.instance.ref().child(
            "bustrackingapp/$institute_doc_u_id/drivers/$driver_doc_u_id");

        var uploadTask = ref.putFile(img_to_file);
        final snapshot = await uploadTask.whenComplete(() {});
        new_profile_img_downloadlink = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("error while trying to upload pic $e");
      }
    }
  }
}
