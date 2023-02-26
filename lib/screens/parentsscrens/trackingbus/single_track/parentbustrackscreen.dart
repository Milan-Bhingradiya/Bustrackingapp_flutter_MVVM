import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/screens/parentsscrens/drawer/parentdrawerwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class parentbustrackscreen extends StatefulWidget {
  @override
  State<parentbustrackscreen> createState() => _parentbustrackscreenState();
}

class _parentbustrackscreenState extends State<parentbustrackscreen> {
  late GoogleMapController mapController;

  bool added = false;
  double homelat = 0;
  double homelong = 0;
  late BitmapDescriptor icon;

  final Set<Marker> markers = new Set();

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/home2.png");
    setState(() {
      this.icon = icon;
    });
  }

  // Future<Uint8List> futurefunc() async {
  //   return markericonofbus;
  // }

  // this function for call upper function.
  // insise inisatte direct not call with async so put in another call function and
  //then call inside this function so we can call in initstat .maybe u dont under stand :)((()))

  Future<void> updatecamerapos(snapshot) async {
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 14.4,
          target: LatLng(
            snapshot.data!.get('letitude'),
            snapshot.data!.get('longitude'),
          ))),
    );
  }

// this function for  get  of lat long value from parent after givven document id
  void sethome() async {
    final data = await FirebaseFirestore.instance
        .collection("parents")
        .doc(Provider.of<Alldata>(context, listen: false)
            .parent_document_id_afterlogin)
        .get();

    homelat = data['letitude'];
    homelong = data['longitude'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Provider.of<Alldata>(context, listen: false).make_and_assign_icon();
    // getIcons();
    // sethome();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   callgetbytefromasset();
  // }

  @override
  Widget build(BuildContext context) {
    print("widget build");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Live Tracking",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // drawer: parentdrawer(),
      body:
      
       Container(
          // padding: EdgeInsets.only(top: 20, bottom: 35, left: 10, right: 10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('drivers')
                  .doc(Provider.of<Alldata>(context, listen: false)
                      .track_single_bus_document_id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (added) {
                  updatecamerapos(snapshot);
                }

                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      mapController = controller;
                      added = true;
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 14.4,
                        target: LatLng(snapshot.data!.get('letitude'),
                            snapshot.data!.get('longitude'))),
                    markers: {
                      //this marker showwww home logo of parent
                      //ok again chnage for git

                      Marker(
                          markerId: MarkerId("home"),
                          position: LatLng(homelat, homelong),
                          // icon: icon,
                          icon: Provider.of<Alldata>(context, listen: false)
                              .homeicon),
                      ///////////////////////////////////////
                      // ///
                      //  BitmapDescriptor.fromBytes(
                      //     Provider.of<Alldata>(context, listen: false)
                      //         .markericonofhome),

                      ///////////////////////////////////

                      // this logo showww bbus  hereeeeeeeeee
                      Marker(
                          markerId: MarkerId("a"),
                          position: LatLng(snapshot.data!.get('letitude'),
                              snapshot.data!.get('longitude')),
                          icon: Provider.of<Alldata>(context, listen: false)
                              .busicon),
                    },
                  );
                }
              })),
    );
  }
}
