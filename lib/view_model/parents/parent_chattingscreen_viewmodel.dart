import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Parent_chattingscreen_viremodel extends ChangeNotifier {
  var profile_img_link;
  var drivername;
  var busnum;

  //for parnet chat with which driver ...store in db..
  var driver_doc_u_id;
  var driver_name;

  Future<void> upload_msg_to_db(context, chat_controller) async {
    Parent_firestore_service parent_firestore_service =
        Parent_firestore_service();

    final parent_login_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);

    final institute_doc_id = parent_login_viewmodel.institute_doc_u_id;
    final parent_doc_u_id = parent_login_viewmodel.parent_doc_u_id;
    // driver u id already we have in this class

// uid that inside chat collection
    final parent_chat_id = "with_d_${driver_doc_u_id.toString()}";

    final driver_chat_id =
        "with_p_${parent_login_viewmodel.parent_doc_u_id.toString()}";

//get sender-receivername..
    String sender = parent_login_viewmodel.parent_doc_u_id.toString();
    String receive = driver_doc_u_id;

    final msg_data_sendtype = {
      "date": DateTime.now(),
      "milisecond": DateTime.now().microsecondsSinceEpoch.toString(),
      "is_seen": false,
      "msg": chat_controller.text,
      "send_or_recive": "send",
      "sender": sender.toString(),
      "receiver": receive.toString(),
    };

    final msg_data_receivetype = {
      "date": DateTime.now(),
      "milisecond": DateTime.now().microsecondsSinceEpoch.toString(),
      "is_seen": false,
      "msg": chat_controller.text,
      "send_or_recive": "receive",
      "sender": sender.toString(),
      "receiver": receive.toString(),
    };

    parent_firestore_service.upload_chat_to_db(
        institute_doc_id,
        parent_doc_u_id,
        driver_doc_u_id,
        parent_chat_id,
        driver_chat_id,
        msg_data_sendtype,
        msg_data_receivetype);
  }
}
