import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Alldata extends ChangeNotifier {
  bool marker_of_home_and_bus_set = false;

  late String parent_document_id_afterlogin;
  late String driver_documentid_after_login;

  late String track_single_bus_document_id;

/////////////////////////////////////////////////////////////////////////////////////////////////
//  make icon of home and bus
  late BitmapDescriptor homeicon;
  late BitmapDescriptor busicon;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void make_and_assign_icon() async {
    late final Uint8List homeicon2;
    late final Uint8List busicon2;

    homeicon2 = await getBytesFromAsset('assets/images/home2.png', 100);
    homeicon = BitmapDescriptor.fromBytes(homeicon2);
    busicon2 = await getBytesFromAsset('assets/images/bus.png', 100);
    busicon = BitmapDescriptor.fromBytes(busicon2);
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

  String selected_schholname_from_schhol_auth = "";

  void set_selected_schholname_from_schhol_auth(String temp) {
    selected_schholname_from_schhol_auth = temp;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  var parent_login_verification_id;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  List list_of_selected_bus = [];

//////

  List<DropdownMenuItem> list_of_institute_dropdownitem = [];

  void fill_list_of_institute_dropdownitem() async {
    print("bbbbbbbbbbbbbbbbbbbbbbbbb");
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
        .collection("main")
        .doc("main_document")
        .collection("institute_list")
        .get();

    querysnapshot.docs.forEach((doc) {
      list_of_institute_dropdownitem.add(DropdownMenuItem(
          value: doc.id.toString(), child: Text(doc.id.toString())));
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//TODO:  aya chhe after login nu badhu
  late String parent_selected_institute_at_login_at_parentlogin;

   late String driver_selected_institute_at_driverlogin;
    late String driver_name_at_driverlogin;
}
