import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class Schooladmin_driver_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  dynamic schooladmin_loginscreen_viewmodel = null;

  String? institute_doc_id;
  String? bus_doc_u_id;
  String? bus_num;
  String? drivername;
  String? driverphonenumber;
  String? driverpassword;
  String? confirmdriverpassword;

  String? selected_profileimg_path;
  String? profile_img_downloadlink;

  List<DropdownMenuItem<String>> listof_bus_dropdown = [];

  List<DropdownMenuItem<String>> get_listof_bus_dropdown() {
    return listof_bus_dropdown;
  }

//
  Future<void> read_data_and_fill_list_of_bus_dropdown(context) async {
    schooladmin_loginscreen_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);

    // QuerySnapshot mm = await firebase.collection("drivers").get();
    listof_bus_dropdown.clear();
    QuerySnapshot mm = await schooladmin_firestore_service
        .get_buses_snapshot(schooladmin_loginscreen_viewmodel.institute_doc_id);

    mm.docs.forEach((doc) {
      if (doc["assigned"] == false) {
        listof_bus_dropdown.add(DropdownMenuItem(
          key: Key(doc.id.toString()),
          value: doc["busnum"].toString(),
          child: Text("${doc["busnum"].toString()}"),
        ));
      }
    });
    notifyListeners();
  }

  // direct write here... in future write in serviceses...
  Future<String> pick_img_and_returnpath() async {
    XFile? pickedimg;

    pickedimg = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedimg != null) {
      // file = io.File(pickedimg!.path);
      selected_profileimg_path = pickedimg.path.toString();
      return pickedimg.path.toString();
    } else {
      return "";
    }
  }

  Future<void> upload_pic_and_save_downloadlink() async {
    if (selected_profileimg_path == "" || selected_profileimg_path == null) {
      //this mean imh is not selected
      print("for upload img u not selected any img");
    } else {
      io.File img_to_file = io.File(selected_profileimg_path.toString());

      try {
        String id = "${drivername}_${driverphonenumber}";
        final ref = await FirebaseStorage.instance
            .ref()
            .child("bustrackingapp/$institute_doc_id/drivers/$id");

        var uploadTask = ref.putFile(img_to_file);
        final snapshot = await uploadTask.whenComplete(() {});
        profile_img_downloadlink = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("error while trying to upload pic $e");
      }
    }
  }

  Future<bool> add_driver(context) async {
    if (selected_profileimg_path == null || selected_profileimg_path == "") {
      //means not selected img
    } else {
      print("start uploading parent profile");
      await upload_pic_and_save_downloadlink();
      // after upload img this function set variable->  new_profile_img_downloadlink
    }

//use this only for getting institute name ....
    final schooladmin_login_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);
  final fcmtoken = await FirebaseMessaging.instance.getToken();

    print("inside add driver in school admin");
    print(fcmtoken);
    institute_doc_id = schooladmin_login_viewmodel.institute_doc_id;
    return await schooladmin_firestore_service.add_driver(
      institute_doc_id,
      bus_doc_u_id,
      bus_num,
      drivername,
      driverphonenumber,
      confirmdriverpassword,
      profile_img_downloadlink,
      fcmtoken
    );
  }


  
  Future<bool> delete_driver(context,driver_doc_id) async {
   

//use this only for getting institute name ....
    final schooladmin_login_viewmodel =
        Provider.of<Schooladmin_loginscreen_viewmodel>(context, listen: false);
 
    institute_doc_id = schooladmin_login_viewmodel.institute_doc_id;
    return await schooladmin_firestore_service.delete_driver(
      institute_doc_id,driver_doc_id
     
    );
  }
}
