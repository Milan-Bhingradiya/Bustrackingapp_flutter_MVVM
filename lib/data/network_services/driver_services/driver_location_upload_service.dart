import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Driver_location_upload_service {
  StreamSubscription<Position>? positionStream;
  void get_livelocation_and_upload_to_db(
      institutename, drivername, bool on_or_off) async {
    if (on_or_off == true) {
      positionStream = await Geolocator.getPositionStream(
          locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
      )).listen((Position? position) async {
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}');

        try {
          await FirebaseFirestore.instance
              .collection('main')
              .doc("main_document")
              .collection("institute_list")
              //TODO: institute ma variable avse
              .doc(institutename)
              .collection("drivers")
              //TODO: arshil bhai ni jagya a variable avse
              .doc(drivername)
              .update({
            'letitude': position?.latitude,
            'longitude': position?.longitude,
          });

          //print("${position?.latitude}" + "${position?.longitude}");
        } catch (e) {
          print("aaaaa ${e.toString()}");
        }
      });
      print("strat live location");
    } else if (on_or_off == false) {
      // positionStream?.cancel();

      if (positionStream == null) {
      } else {
        positionStream?.cancel();
        print("after stp");
      }
    }
  }
}
