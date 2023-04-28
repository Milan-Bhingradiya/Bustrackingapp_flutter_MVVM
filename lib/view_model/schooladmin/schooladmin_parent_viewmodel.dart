import 'package:bustrackingapp/services/network_services/schooladmin_services/schooladmin_firestore_service.dart';

import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class Schooladmin_parent_viewmodel extends ChangeNotifier {
  Schooladmin_firestore_service schooladmin_firestore_service =
      Schooladmin_firestore_service();
  String? institute_doc_id;
  String? selectedbusnum;
  String? parentname;
  String? parentphonenumber;
  String? parentchildname;
  String? parentpassword;
  String? confirmparentpassword;
  String? letitude;
  String? longitude;

  String? selected_profileimg_path;
  String? profile_img_downloadlink;

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
        String id = "${parentname}_${parentphonenumber}";
        final ref = await FirebaseStorage.instance
            .ref()
            .child("bustrackingapp/$institute_doc_id/parents/$id");

        var uploadTask = ref.putFile(img_to_file);
        final snapshot = await uploadTask.whenComplete(() {});
        profile_img_downloadlink = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("error while trying to upload pic $e");
      }
    }
  }

  Future<bool> add_parent(context) async {
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

    institute_doc_id = schooladmin_login_viewmodel.institute_doc_id;

    return await schooladmin_firestore_service.add_parent(
        institute_doc_id,
        parentname,
        parentphonenumber,
        parentchildname,
        confirmparentpassword,
        letitude,
        longitude,
        profile_img_downloadlink);
  }
}
