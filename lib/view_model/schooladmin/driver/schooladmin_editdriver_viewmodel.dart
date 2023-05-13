import 'package:bustrackingapp/services/network_services/driver_services/driver_firebasestorage_service.dart';
import 'package:bustrackingapp/services/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class Schooladmin_editdriver_viewmodel extends ChangeNotifier {
  // this variable assign at llst of drivr screen when user select for update driver
  //then using this id we get data and show user and then update
  String? driver_doc_id;
  String? institute_doc_id;

  //
  //after get data from firestore
  String? drivername;
  String? driverphonenumber;
  int? busnum;
  String? old_busnum_id;
  String? profile_img_downloadlink;

  String? new_drivername;
  String? new_driverphonenumber;
  int? new_busnum;
  String? new_profile_img_downloadlink;

  final TextEditingController drivername_controller = TextEditingController();
  final TextEditingController driverphonenumber_controller =
      TextEditingController();
  final TextEditingController busnum_controller = TextEditingController();

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

  void set_drivername(String s) {
    drivername = s;
    notifyListeners();
  }

  void set_driverphonenumber(String s) {
    driverphonenumber = s;
    notifyListeners();
  }

  void set_busnum(int s) {
    busnum = s;
    notifyListeners();
  }

  void set_old_busnum_id(String? s) {
    old_busnum_id = s;
    notifyListeners();
  }

  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();

// for getting driver data
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

  // for use img pick function..
  Driver_firebasestorage_service driver_firebasestorage_service =
      Driver_firebasestorage_service();

  dynamic schooladmin_loginscreen_viewmodel = null;

  void get_driver_data(
    context,
  ) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    institute_doc_id =
        schooladmin_loginscreen_viewmodel.institute_doc_id.toString();

    final DocumentSnapshot driverdata = await driver_firestore_service
        .get_driver_doc(institute_doc_id, driver_doc_id);

//dirctly assign..
    old_busnum_id = await schooladmin_firestore_service.get_bus_id_from_busnum(
        busnum, institute_doc_id);

    set_drivername(driverdata.get("drivername").toString());
    set_driverphonenumber(driverdata.get("driverphonenumber").toString());
    set_busnum(int.parse(driverdata.get("busnum").toString()));

    set_old_busnum_id(old_busnum_id);
    set_profile_img_downloadlink(driverdata.get("profile_img_link").toString());
    drivername_controller.text = drivername.toString();
    driverphonenumber_controller.text = driverphonenumber.toString();
    busnum_controller.text = busnum.toString();
  }

  Future<void> select_img() async {
    set_selected_profileimg_path(
        await driver_firebasestorage_service.pick_img_and_returnpath());
  }

  // profile upload
  Future<bool> edit_profile() async {
    if (selected_profileimg_path == null || selected_profileimg_path == "") {
      //means not selected img
    } else {
      print("start uploading parent profile");
      await upload_pic_and_save_downloadlink();
      // after upload img this function set variable->  new_profile_img_downloadlink
    }
 final new_busnum_id= await schooladmin_firestore_service.get_bus_id_from_busnum( new_busnum, institute_doc_id);
       
    bool updated_or_failed =
        await schooladmin_firestore_service.driver_profile_edit(
      institute_doc_id,
      driver_doc_id,
      new_drivername,
      new_driverphonenumber,
      old_busnum_id, //old busnum
      new_busnum, //new busnum
    new_busnum_id,
      (new_profile_img_downloadlink == null ||
              new_profile_img_downloadlink == "")
          ? profile_img_downloadlink
          : new_profile_img_downloadlink,
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
            .child("bustrackingapp/$institute_doc_id/drivers/$driver_doc_id");

        var uploadTask = ref.putFile(img_to_file);
        final snapshot = await uploadTask.whenComplete(() {});
        new_profile_img_downloadlink = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("error while trying to upload pic $e");
      }
    }
  }
}
