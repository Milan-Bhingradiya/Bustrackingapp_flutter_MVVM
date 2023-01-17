import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Alldata extends ChangeNotifier {
  bool marker_of_home_and_bus_set = false;
  
  late String parent_document_id_afterlogin;

  late final Uint8List markericonofhome;
  late final Uint8List markericonofbus;

// this function convvert img to byte may beee
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

//below code assign image logo to variable at initstate
//main problem here is both variable in one function if i do than it gives error
// markericon of bus no intialied so i make  2 below  function.

  void callgetbytefromassetforhomeicon() async {
    markericonofhome = await getBytesFromAsset('assets/images/home2.png', 100);
    // markericonofbus = await getBytesFromAsset('assets/images/bus2.png', 100);
  }

  void callgetbytefromassetforbusicon() async {
    //   markericonofhome = await getBytesFromAsset('assets/images/home2.png', 100);
    markericonofbus = await getBytesFromAsset('assets/images/bus.png', 100);
  }
}
