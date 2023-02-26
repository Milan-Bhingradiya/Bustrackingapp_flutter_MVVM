// this file contain list of bus which i show in track map scareen below side

import 'package:bustrackingapp/screens/parentsscrens/trackingbus/track/widgets/bus_and_num.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

List<bus_and_num> list_of_bus = [
  // bus_and_num(busnum: "108", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "21", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "14", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "17", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "02", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "108", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "21", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "14", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "17", img_path: "assets/images/bus.png"),
  // bus_and_num(busnum: "02", img_path: "assets/images/bus.png"),
];

void create_list_of_bus() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('drivers').get();

  querySnapshot.docs.forEach((element) {
    list_of_bus.add(bus_and_num(
        busnum: element.get("busnum"), img_path: "assets/images/bus.png"));
  });
}
