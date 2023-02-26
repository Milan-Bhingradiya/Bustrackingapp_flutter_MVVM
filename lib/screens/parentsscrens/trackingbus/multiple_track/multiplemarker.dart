import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/track/data/list_of_bus.dart';
import 'package:bustrackingapp/screens/school_admin/buses/list_of_bus_screen.dart';
import 'package:bustrackingapp/screens/school_admin/drivers/listofdriverscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class multiplemarker extends StatefulWidget {
  const multiplemarker({super.key});

  @override
  State<multiplemarker> createState() => _dummyState();
}

class _dummyState extends State<multiplemarker> {
  List<model> listofmodel = [];
  final Set<Marker> markers = new Set();

//firestore to object
  List<model> firestore_to_model() {
    try {
      FirebaseFirestore.instance
          .collection('drivers')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          model m = model(doc);
          listofmodel.add(m);

          // listofmodel.removeWhere((elementt) =>
          //     elementt.drivername ==
          //     list_of_bus.where((element) => element == elementt));
        });
      });
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeerooooooooooooooooooo $e");
    }

    print(listofmodel.length);
    return listofmodel;
  }

  void allbusmodel_to_onlyselectedbusmodel(context) {
    print("aal bus ${listofmodel.length} ");
    listofmodel.removeWhere((elementt) {
      return elementt.busnum ==
          Provider.of<Alldata>(context, listen: false)
              .list_of_selected_bus
              .where((element) => element != elementt.busnum);
    });

    print("slected bus only   ${listofmodel.length}           ");
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
        position: LatLng(double.parse(listofmodel[i].lat),
            double.parse(listofmodel[i].long)),
        icon: Provider.of<Alldata>(context, listen: false).busicon,
      ));
    }
  }

  Future<void> recall_func() async {
    Future.delayed(Duration(seconds: 3), () {
      print("Executed after 1 seconds");
      setState(() {
        firestore_to_model();
        makemarker(context);
        listofmodel.clear();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Alldata>(context, listen: false).make_and_assign_icon();
    recall_func();
  }

  @override
  Widget build(BuildContext context) {
    print("wiget buildddddddddddddddddddddddddddddddddddddddddd");
    return FutureBuilder(
      future: recall_func(),
      builder: (context, snapshot) {
        return Container(
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(zoom: 10.4, target: LatLng(21, 71)),
            markers: markers,
          ),
        );
      },
    );
  }


 
}
