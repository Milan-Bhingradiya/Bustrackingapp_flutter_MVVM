import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bustrackingapp/providers/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'model.dart';

List<model> listofmodel = [];
final Set<Marker> markers = new Set();

List<model> firestore_to_model()  {
  


  FirebaseFirestore.instance
      .collection('drivers')
      // .doc('ramu3')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      // print(doc["drivername"]);
      model m = model(doc);
      listofmodel.add(m);
    });
  });
  print(listofmodel.length);

  return listofmodel;
}

void makemarker(context) {
  markers.add(Marker(
    markerId: MarkerId("home"),
    position: LatLng(21.98765, 71.9876543),
    icon: Provider.of<Alldata>(context, listen: false).homeicon,
  ));

  for (var i = 1; i < (listofmodel.length - 1); i++) {
    markers.add(Marker(
      markerId: MarkerId(
        listofmodel[i].drivername,
      ),
      position: LatLng(
          double.parse(listofmodel[i].lat), double.parse(listofmodel[i].long)),
      icon: Provider.of<Alldata>(context, listen: false).busicon,
    ));
  }
}

class multiplemarker extends StatefulWidget {
  const multiplemarker({super.key});

  @override
  State<multiplemarker> createState() => _dummyState();
}

class _dummyState extends State<multiplemarker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Alldata>(context, listen: false).make_and_assign_icon();
  }

  @override
  Widget build(BuildContext context) {
    print("multiplemarker wiget buildddddddddddddddddddddddddddddddddddddddddd");
    Future.delayed(Duration(seconds: 1), () {
      print("Executed after 1 seconds");
      setState(() {
        firestore_to_model();
        makemarker(context);

        listofmodel.clear();
      });
    });

    return Container(
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(zoom: 10.4, target: LatLng(21, 71)),
        markers: markers,
      ),
    );
  }
}
