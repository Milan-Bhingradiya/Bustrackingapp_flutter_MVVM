import 'package:bustrackingapp/model/parent/profile/parentlocation_model.dart';
import 'package:bustrackingapp/respository/parent/parent_profile_repo.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Parent_profilescreen_viewmodel extends ChangeNotifier {
  final Parent_profile_repo parent_profile_repo = Parent_profile_repo();

  String new_parentchildname = "";
  String new_parentphonenumber = "";
  String new_parentname = "";
  double? new_parentlat;
  double? new_parentlong;

  late String institutename;
  late String parentname;

//
  void get_parent_data_and_fill_in_textfield(
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
    institutename =
        parent_login_viewmodel.parent_selected_institute_at_login.toString();
    parentname = parent_login_viewmodel.parent_entered_name_at_login.toString();

    ///
    final DocumentSnapshot parentdata = await parent_profile_repo
        .get_parent_document_using_parentname_and_institutename(
            institutename, parentname);

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
    }
  }

//set current location
  Future<bool> ask_for_loctaion_permission() async {
    return await parent_profile_repo.ask_for_loctaion_permission();
  }

  Future<void> set_current_location(
      parentletitudecontroller, parentlongitudecontroller) async {
    parentlocation_model locationdata =
        await parent_profile_repo.set_current_location();

    new_parentlat = locationdata.letitude;
    new_parentlong = locationdata.longitude;

    //for showing in diaplay
    parentletitudecontroller.text = new_parentlat.toString();
    parentlongitudecontroller.text = new_parentlong.toString();
  }

  // profile upload

  Future<bool> upload_profile() async {
    bool updated_or_failed = await parent_profile_repo.upload_parent_profile(
        institutename,
        parentname,
        new_parentname,
        new_parentchildname,
        new_parentphonenumber,
        new_parentlat,
        new_parentlong);
    print("aaa $updated_or_failed");
    return updated_or_failed;
  }
}
