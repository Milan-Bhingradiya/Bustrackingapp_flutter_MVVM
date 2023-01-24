import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
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

}


