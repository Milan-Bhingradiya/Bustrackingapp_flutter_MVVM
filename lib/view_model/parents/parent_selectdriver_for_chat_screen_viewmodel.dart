import 'package:bustrackingapp/model/parent/chat/model_of_drivers.dart';
import 'package:bustrackingapp/res/component/parent/chat/driver_list/chat_box_with_profile.dart';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Parent_selectdriver_for_chat_screen_viewmodel extends ChangeNotifier {
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();
  List<parent_chat_box_with_profile> list_of_drivers_chatbox_widget = [];

  List<Modelofdrivers> list_of_drivers_model = [];

  dynamic parent_loginscreen_viewmodel = null;

  Future<void> make_all_drivers_chatbox(context) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    list_of_drivers_chatbox_widget.clear();
    list_of_drivers_model.clear();
    parent_loginscreen_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);

    final institutename_u_id = parent_loginscreen_viewmodel.institute_doc_u_id;

    try {
      final querySnapshot = await parent_firestore_service
          .get_driver_documentist_of_given_institutename(institutename_u_id);

      print("size of driver model list ::: ${querySnapshot.size}");

      querySnapshot.docs.forEach((doc) {
        Modelofdrivers obj = Modelofdrivers(doc);
        list_of_drivers_model.add(obj);
      });

      print(
          "size of list_of_driermodel for chat : $list_of_drivers_model.length}");
    } catch (e) {
      print("first erorrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
    }

///////////////done making list of drivermodel///////////////////////////

    for (var i = 0; i < list_of_drivers_model.length; i++) {
      list_of_drivers_chatbox_widget.add(parent_chat_box_with_profile(
        title: list_of_drivers_model[i].drivername,
        subtitile: list_of_drivers_model[i].driverphonenumber,
        profileimglink:
            "https://firebasestorage.googleapis.com/v0/b/bustrackingapp00final.appspot.com/o/bustrackingapp%2Fbrilliant%20vidyalaya%2Fparent%2Fbabubhainotyo_9016064322?alt=media&token=72fe0664-0db4-40d8-bd7c-941994c494c3",
        u_id: list_of_drivers_model[i].driver_doc_u_id,
      ));
    }
  }
}
