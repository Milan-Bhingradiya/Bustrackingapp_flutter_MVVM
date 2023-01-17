import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model.dart';

List<model> listofmodel = [];
final Set<Marker> markers = new Set();

Future<List<model>> firestoretomodel() async {
  await Future.delayed(Duration(seconds: 3), () {
    print("Executed after 5 seconds");
  });

  // final Document =
  //     FirebaseFirestore.instance.collection('drivers').doc('ramu3');

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

void makemarker() {
  for (var i = 0; i < (listofmodel.length - 1); i++) {
    markers.add(Marker(
      markerId: MarkerId(
        listofmodel[i].drivername,
      ),
      position: LatLng(
          double.parse(listofmodel[i].lat), double.parse(listofmodel[i].long)),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
}

class dummy extends StatefulWidget {
  const dummy({super.key});

  @override
  State<dummy> createState() => _dummyState();
}

class _dummyState extends State<dummy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      print("Executed after 5 seconds");
      setState(() {
        firestoretomodel();
        makemarker();
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
