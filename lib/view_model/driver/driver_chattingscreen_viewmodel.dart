import 'package:bustrackingapp/services/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Driver_chattingscreen_viewmodel extends ChangeNotifier {
  var profile_img_link;
  var parentname;

  //for parnet chat with which driver ...store in db..
  var parent_doc_u_id;
  var parent_name;

  Future<void> upload_msg_to_db(context, chat_controller) async {
    Driver_firestore_service driver_firestore_service =
        Driver_firestore_service();

    final driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);

    final institute_doc_id = driver_login_viewmodel.institute_doc_u_id;
    final driver_doc_u_id = driver_login_viewmodel.driver_doc_u_id;
    // driver u id already we have in this class

// uid that inside chat collection
    final parent_chat_id =
        "with_d_${driver_login_viewmodel.driver_doc_u_id.toString()}";

    final driver_chat_id = "with_p_${parent_doc_u_id.toString()}";

//get sender-receivername..
    String sender = driver_login_viewmodel.driver_doc_u_id.toString();
    String receive = parent_doc_u_id;

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

    driver_firestore_service.upload_chat_to_db(
        institute_doc_id,
        parent_doc_u_id,
        driver_doc_u_id,
        parent_chat_id,
        driver_chat_id,
        msg_data_sendtype,
        msg_data_receivetype);
  }
}
