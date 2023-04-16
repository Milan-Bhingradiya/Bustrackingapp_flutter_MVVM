import 'package:bustrackingapp/data/network_services/driver_services/driver_firestore_service.dart';
import 'package:bustrackingapp/model/driver/showmap/model_parents.dart';

import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class Driver_showmapscreen_viewmodel extends ChangeNotifier {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

  late String institutename;

  List<modelofparents> list_of_parentmodel = [];
  Set<Marker> list_of_markers_of_home = new Set();

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

  ///////----------
  void fill_list_of_parentmodel(context) async {
    /// get institute name from another viewmodel...
    final driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);

    institutename = await driver_login_viewmodel
        .driver_selected_institute_at_driverlogin
        .toString();

    ///
    try {
      final querySnapshot = await driver_firestore_service
          .get_parent_documentist_of_given_institutename(institutename);

      print("oooooooo ${querySnapshot.size}");
      querySnapshot.docs.forEach((doc) {
        // print(doc["drivername"]);

        modelofparents obj = modelofparents(doc);
        list_of_parentmodel.add(obj);
      });

      print("size of list_of_parentmodel : $list_of_parentmodel.length}");
    } catch (e) {
      print("first erorrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
    }
  }

  //======================

  Future<void> fill_list_of_marker_of_parent() async {
    try {
      for (int x = 0; x < (list_of_parentmodel.length); x++) {
        await list_of_markers_of_home.add(Marker(
          markerId: MarkerId(
            list_of_parentmodel[x].parentname,
          ),
          position: LatLng(double.parse(list_of_parentmodel[x].lat),
              double.parse(list_of_parentmodel[x].long)),
          icon: homeicon,
        ));
      }
    } catch (e) {
      
      print("second erorrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
    }
  }
}
