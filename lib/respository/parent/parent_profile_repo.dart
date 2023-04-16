import 'package:bustrackingapp/data/network_services/parent_services/parent_firebasestorage_service.dart';
import 'package:bustrackingapp/data/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/model/parent/profile/parentlocation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Parent_profile_repo {
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();

  Parent_firebasestorage_service parent_firebasestorage_service =
      Parent_firebasestorage_service();

  Future<DocumentSnapshot>
      get_parent_document_using_parentname_and_institutename(
          institutename, parentname) async {
    final doc = await parent_firestore_service.get_parent_doc(
        institutename, parentname);
    return doc;
  }

  Future<bool> upload_parent_profile(institutename, parentname, new_parentname,
      new_parentchildname, new_parentphonenumber, parentlat,parentlong,profile_img_downloadlink) async {
    bool updated_or_failed =
        await parent_firestore_service.parent_profile_upload(
            institutename,
            parentname,
            new_parentname,
            new_parentchildname,
            new_parentphonenumber,
            parentlat,
            parentlong,profile_img_downloadlink);
    return updated_or_failed;
  }

  Future<bool> ask_for_loctaion_permission() async {
    return await parent_firestore_service.ask_for_loctaion_permission();
  }

  Future<parentlocation_model> set_current_location() async {
    return await parent_firestore_service.set_current_location();
  }


  Future<String> pick_img_and_return_path() async {
    return await parent_firebasestorage_service.pick_img_and_returnpath();
  }
}
