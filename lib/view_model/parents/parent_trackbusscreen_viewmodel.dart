import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/res/component/parent/trackbus/bus_and_num_widget.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class Parent_trackbusscreen_viewmodel extends ChangeNotifier {
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();
  dynamic parent_loginscreen_viewmodel = null;

  List<bus_and_num_widget> list_of_bus = [];
  List list_of_selected_bus = [];

  Set<Marker> newmarkers = new Set();

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

    homeicon2 = await getBytesFromAsset('assets/images/home.png', 60);
    homeicon = BitmapDescriptor.fromBytes(homeicon2);
    busicon2 = await getBytesFromAsset('assets/images/bus.png', 75);
    busicon = BitmapDescriptor.fromBytes(busicon2);
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void create_list_of_bus(context) async {
    //for getting institute name
    parent_loginscreen_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);
    //----------
    QuerySnapshot querySnapshot =
        await parent_firestore_service.get_driver_collection_querysnapshot(
            parent_loginscreen_viewmodel.institute_doc_u_id);

    // await FirebaseFirestore.instance.collection('drivers').get();
    print(
        "mmmmmmmmmmmmmmmmmmmmmmmm ${parent_loginscreen_viewmodel.institute_doc_u_id}");
    querySnapshot.docs.forEach((element) {
      list_of_bus.add(bus_and_num_widget(
          busnum: element.get("busnum").toString(),
          img_path: "assets/images/bus.png"));
    });
  }

  void create_markers(document) async {
    for (var i = 0; i < list_of_selected_bus.length; i++) {
      if (document.get("busnum").toString() == list_of_selected_bus[i]) {
        newmarkers.add(Marker(
            markerId: MarkerId(document.get("busnum").toString()),
            position:
                LatLng(document.get("letitude"), document.get("longitude")),
            infoWindow: InfoWindow(
              title: "${document.get("drivername")}",
              snippet: "${document.get("driverphonenumber")}",
            ),
            icon: busicon));
      }
    }
  }
}
