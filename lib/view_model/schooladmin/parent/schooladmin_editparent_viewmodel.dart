import 'package:bustrackingapp/services/network_services/driver_services/driver_firebasestorage_service.dart';
import 'package:bustrackingapp/services/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firebasestorage_service.dart';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class Schooladmin_editparent_viewmodel extends ChangeNotifier {
  // this variable assign at llst of drivr screen when user select for update driver
  //then using this id we get data and show user and then update
  String? parent_doc_id;
  String? institute_doc_id;

  //
  //after get data from firestore
  String? parentname;
  String? parentphonenumber;
  String? parentchildname;

  String? new_parentname;
  String? new_parentphonenumber;
  String? new_parentchildname;

  String? profile_img_downloadlink;
  String? new_profile_img_downloadlink;

  final TextEditingController parentname_controller = TextEditingController();
  final TextEditingController parentphonenumber_controller =
      TextEditingController();
  final TextEditingController parentchildname_controller =
      TextEditingController();

  //pick image from device and set path
  String? selected_profileimg_path;

  void set_profile_img_downloadlink(String s) {
    profile_img_downloadlink = s;
    notifyListeners();
  }

  void set_selected_profileimg_path(String s) {
    selected_profileimg_path = s;
    notifyListeners();
  }

  void set_parentname(String s) {
    parentname = s;
    notifyListeners();
  }

  void set_parentphonenumber(String s) {
    parentphonenumber = s;
    notifyListeners();
  }

  void set_parentchildname(String s) {
    parentchildname = s;
    notifyListeners();
  }

  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();

// for getting driver data
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();

  // for use img pick function..
  Parent_firebasestorage_service parent_firebasestorage_service =
      Parent_firebasestorage_service();

  dynamic schooladmin_loginscreen_viewmodel = null;

  void get_parent_data(
    context,
  ) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    institute_doc_id =
        schooladmin_loginscreen_viewmodel.institute_doc_id.toString();

    final DocumentSnapshot driverdata = await parent_firestore_service
        .get_parent_doc(institute_doc_id, parent_doc_id);

    set_parentname(driverdata.get("parentname").toString());
    set_parentphonenumber(driverdata.get("parentphonenumber").toString());
    set_parentchildname(driverdata.get("parentchildname").toString());
    set_profile_img_downloadlink(driverdata.get("profile_img_link").toString());

    parentname_controller.text = parentname.toString();
    parentphonenumber_controller.text = parentphonenumber.toString();
    parentchildname_controller.text = parentchildname.toString();
  }

  Future<void> select_img() async {
    set_selected_profileimg_path(
        await parent_firebasestorage_service.pick_img_and_returnpath());
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
        await parent_firestore_service.schooladmin_parent_profile_upload(
      institute_doc_id,
      new_parentname,
      new_parentphonenumber,
      new_parentchildname,
      (new_profile_img_downloadlink == null ||
              new_profile_img_downloadlink == "")
          ? profile_img_downloadlink
          : new_profile_img_downloadlink,
      parent_doc_id,
    );

    print("aaa $updated_or_failed");
    return updated_or_failed;
  }

  Future<void> upload_pic_and_save_downloadlink() async {
    if (selected_profileimg_path == "" || selected_profileimg_path == null) {
      //this mean imh is not selected
      print("for upload img u not selected any img");
    } else {
      io.File img_to_file = io.File(selected_profileimg_path.toString());

      try {
        // String id = "${new_drivername}_${new_driverphonenumber}";
        final ref = await FirebaseStorage.instance
            .ref()
            .child("bustrackingapp/$institute_doc_id/drivers/$parent_doc_id");

        var uploadTask = ref.putFile(img_to_file);
        final snapshot = await uploadTask.whenComplete(() {});
        new_profile_img_downloadlink = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("error while trying to upload pic $e");
      }
    }
  }
}
