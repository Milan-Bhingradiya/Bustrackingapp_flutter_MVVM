import 'package:bustrackingapp/model/driver/showmap/model_parents.dart';
import 'package:bustrackingapp/view_model/driver/driver_showmapscreen_viewmodel.dart';
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
  dynamic driver_showmapscreen_viewmodel = null;

  void milanop() async {
    driver_showmapscreen_viewmodel =
        await Provider.of<Driver_showmapscreen_viewmodel>(context,
            listen: false);

    driver_showmapscreen_viewmodel.make_and_assign_icon();
    await driver_showmapscreen_viewmodel.fill_list_of_parentmodel(context);
    driver_showmapscreen_viewmodel.fill_list_of_marker_of_parent();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (driver_showmapscreen_viewmodel == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  zoom: 6,
                  target: LatLng(21.999, 71.990),
                ),
                markers: driver_showmapscreen_viewmodel.list_of_markers_of_home,
              ),
            ),
    );
  }
}
