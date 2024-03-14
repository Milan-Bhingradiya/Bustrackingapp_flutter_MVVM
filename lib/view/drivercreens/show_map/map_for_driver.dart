import 'package:bustrackingapp/model/driver/showmap/model_parents.dart';
import 'package:bustrackingapp/view_model/driver/driver_showmapscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';

class mapfordriver extends StatefulWidget {
  const mapfordriver({super.key});

  @override
  State<mapfordriver> createState() => _mapfordriverState();
}

class _mapfordriverState extends State<mapfordriver> {
  final google_apikey = "AIzaSyAOegRO3d43MVnEdk75Kv2ydr68BFgMERQ";
  dynamic driver_showmapscreen_viewmodel = null;

  void milanop() async {
    driver_showmapscreen_viewmodel =
        await Provider.of<Driver_showmapscreen_viewmodel>(context,
            listen: false);

    driver_showmapscreen_viewmodel.make_and_assign_icon();
    await driver_showmapscreen_viewmodel.fill_list_of_parentmodel(context);
    await driver_showmapscreen_viewmodel.fill_list_of_marker_of_parent();
    setState(() {});
  }

  double _originLatitude = 26.48424, _originLongitude = 50.04551;
  double _destLatitude = 26.46423, _destLongitude = 50.06358;
  List<LatLng> polylineCoordinates = [
    LatLng(20.12, 70.12),
    LatLng(21.12, 71.12),
    LatLng(22.12, 72.12)
  ];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines_map = {};

  void addpolyline() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, points: polylineCoordinates, color: Colors.red);
    polylines_map[id] = polyline;
    setState(() {});
    print("adpolu line called");
  }

  void getpolyline() async {
    PolylineResult? result;
    try {
      result = await polylinePoints.getRouteBetweenCoordinates(
        google_apikey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
      );
    } catch (e) {
      print("xxx $e");
    }

    print("rrsult is ${result!.errorMessage}");
    if (result!.points.isNotEmpty) {
      print("rrsult is not emlptyyyyyyyyy");
      result.points.forEach((PointLatLng p) {
        polylineCoordinates.add(LatLng(p.latitude, p.longitude));
      });
    }
    addpolyline();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
    // getpolyline();
    // addpolyline();
  }

  @override
  Widget build(BuildContext context) {
    print("widget buld");

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
                // polylines: Set<Polyline>.of(polylines_map.values),
              ),
            ),
    );
  }
}
