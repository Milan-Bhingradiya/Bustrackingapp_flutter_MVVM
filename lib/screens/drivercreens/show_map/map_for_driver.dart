import 'package:bustrackingapp/screens/drivercreens/show_map/model_parents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';

class mapfordriver extends StatefulWidget {
  const mapfordriver({super.key});

  @override
  State<mapfordriver> createState() => _mapfordriverState();
}

class _mapfordriverState extends State<mapfordriver> {
  List<modelofparents> list_of_parentmodel = [];
  Set<Marker> list_of_markers_of_home = new Set();
  late final QuerySnapshot querySnapshot;

  Future<List<modelofparents>> fill_list_of_parentmodel() async {
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection("main")
          .doc("main_document")
          .collection("institute_list")
          .doc(Provider.of<Alldata>(context, listen: false)
              .driver_selected_institute_at_driverlogin
              .toString())
          .collection("parents")
          .get();

      // querySnapshot = await FirebaseFirestore.instance
      //     .collection("main")
      //     .doc("main_document")
      //     .collection("institute_list")
      //     .doc(Provider.of<Alldata>(context, listen: false)
      //         .driver_selected_institute_at_driverlogin)
      //     .collection("parents")
      //     .get();
      print("zzzzzzzzzz");
      print("oooooooo ${querySnapshot.size}");
      querySnapshot.docs.forEach((doc) {
        // print(doc["drivername"]);
        print("loda");
        modelofparents obj = modelofparents(doc);
        list_of_parentmodel.add(obj);
      });

      print("bbbbbbbbbbb $list_of_parentmodel.length}");
    } catch (e) {
      print("first erorrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
    }

    return list_of_parentmodel;
  }

  Future<void> fill_list_of_marker_of_parent() async {
    try {
      for (int x = 0; x < (list_of_parentmodel.length); x++) {
        print("inside callll");
        await list_of_markers_of_home.add(Marker(
          markerId: MarkerId(
            list_of_parentmodel[x].parentname,
          ),
          position: LatLng(double.parse(list_of_parentmodel[x].lat),
              double.parse(list_of_parentmodel[x].long)),
          icon: Provider.of<Alldata>(context, listen: false).homeicon,
        ));
      }
      setState(() {});
    } catch (e) {
      print("second erorrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
    }
  }

  void temp() async {
    await fill_list_of_parentmodel();

    fill_list_of_marker_of_parent();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Alldata>(context, listen: false).make_and_assign_icon();

    // print(Provider.of<Alldata>(context, listen: false)
    //     .driver_selected_institute_at_driverlogin);
    temp();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<Alldata>(context, listen: false)
        .driver_selected_institute_at_driverlogin);
    print(list_of_parentmodel.length);
    print(list_of_markers_of_home.length);
    return Container(
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(zoom: 10.4, target: LatLng(21, 71)),
        markers: list_of_markers_of_home ,
      ),
    );
  }
}
