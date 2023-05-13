import 'package:bustrackingapp/model/driver/chat/model_of_parents.dart';
import 'package:bustrackingapp/model/parent/chat/model_of_drivers.dart';
import 'package:bustrackingapp/res/component/driver/chat/parent_list/chat_box_with_profile.dart';
import 'package:bustrackingapp/res/component/parent/chat/driver_list/chat_box_with_profile.dart';
import 'package:bustrackingapp/services/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Driver_selectparent_for_chat_screen_viewmodel extends ChangeNotifier {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();
  List<driver_chat_box_with_profile> list_of_parents_chatbox_widget = [];

  List<Modelofparents> list_of_parents_model = [];

  dynamic driver_loginscreen_viewmodel = null;

  Future<void> make_all_parents_chatbox(context) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    list_of_parents_chatbox_widget.clear();
    list_of_parents_model.clear();
    driver_loginscreen_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);

    final institutename_u_id = driver_loginscreen_viewmodel.institute_doc_u_id;

    try {
      final querySnapshot = await driver_firestore_service
          .get_parent_documentist_of_given_institute_id(institutename_u_id);

      print("size of parent model list ::: ${querySnapshot.size}");

      querySnapshot.docs.forEach((doc) {
        Modelofparents obj = Modelofparents(doc);
        list_of_parents_model.add(obj);
      });
    } catch (e) {
      print("first erorrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
    }

///////////////done making list of parentmodel///////////////////////////

    for (var i = 0; i < list_of_parents_model.length; i++) {
      list_of_parents_chatbox_widget.add(driver_chat_box_with_profile(
        title: list_of_parents_model[i].parentname,
        subtitile: list_of_parents_model[i].parentphonenumber,
        profileimglink:list_of_parents_model[i].profile_img_link,
         u_id: list_of_parents_model[i].parent_doc_u_id,
      ));
    }
  }
}
