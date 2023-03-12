// for animation _bus_logo_animation_conroller uncommet karje future milan
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
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/track/data/list_of_bus.dart';

final pi = 3.14;

class trackscreen extends StatefulWidget {
  @override
  State<trackscreen> createState() => _trackscreen();
}

class _trackscreen extends State<trackscreen> with TickerProviderStateMixin {
//animation

  late Animation _bus_logo_animation;
  late AnimationController _bus_logo_animation_conroller;

  //////
  late GoogleMapController mapController;

  bool added = false;
  double homelat = 0;
  double homelong = 0;
  late BitmapDescriptor icon;

  Set<Marker> markers = new Set();

  Set<Marker> newmarkers = new Set();

  Set<Marker> selected_markers = new Set();
  //
  bool show_listofbus = false;
  bool firstime = true;

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

  @override
  void initState() {
    super.initState();

    create_list_of_bus(context);
//
    Provider.of<Alldata>(context, listen: false).list_of_selected_bus.clear();

    //

    // _bus_logo_animation_conroller = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1200));

    // _bus_logo_animation = Tween(begin: 150.0, end: 170.0).animate(
    //     CurvedAnimation(
    //         curve: Curves.bounceOut, parent: _bus_logo_animation_conroller));

    // _bus_logo_animation_conroller.addStatusListener((AnimationStatus status) {
    //   if (status == AnimationStatus.completed) {
    //     _bus_logo_animation_conroller.repeat();
    //   }
    // });

//
    Provider.of<Alldata>(context, listen: false).make_and_assign_icon();
  }

  @override
  void dispose() {
    // _bus_logo_animation_conroller.dispose();
    // TODO: implement dispose

    super.dispose();
  }

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
        body: Stack(
          // stack first part
          children: [
            Container(
                // padding: EdgeInsets.only(top: 20, bottom: 35, left: 10, right: 10),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('main')
                        .doc("main_document")
                        .collection("institute_list")
                        .doc(Provider.of<Alldata>(context, listen: false)
                            .parent_selected_institute_at_login_at_parentlogin)
                        .collection('drivers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      // if (added) {
                      //   updatecamerapos(snapshot);
                      // }

                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        print("before marker ${newmarkers.length}");
                        newmarkers.clear();

                        //  for all bus track add in new marker
                        // snapshot.data!.docs.forEach((element) {
                        //   newmarkers.add(Marker(
                        //       markerId: MarkerId(element.get("busnum")),
                        //       position: LatLng(element.get("letitude"),
                        //           element.get("longitude")),
                        //       icon: Provider.of<Alldata>(context, listen: false)
                        //           .busicon));
                        // });
                        // print(Provider.of<Alldata>(context, listen: false)
                        //     .list_of_selected_bus
                        //     .toString());

// for only selected bus add in newmarker

                        print(Provider.of<Alldata>(context, listen: false)
                            .list_of_selected_bus
                            .toString());

                        snapshot.data!.docs.forEach(
                          (element) {
                            for (var i = 0;
                                i <
                                    Provider.of<Alldata>(context, listen: false)
                                        .list_of_selected_bus
                                        .length;
                                i++) {
                              if (element.get("busnum") ==
                                  Provider.of<Alldata>(context, listen: false)
                                      .list_of_selected_bus[i]) {
                                newmarkers.add(Marker(
                                    markerId: MarkerId(element.get("busnum")),
                                    position: LatLng(element.get("letitude"),
                                        element.get("longitude")),
                                    icon: Provider.of<Alldata>(context,
                                            listen: false)
                                        .busicon));
                              }
                            }
                          },
                        );
                        print(newmarkers.length);
                        // newmarkers.remove((element) {
                        //   print("zzzzzzzzzzzzzzzzzzzzzzzzz");
                        //   bool want_to_delete = false;
                        //   for (var i = 0;
                        //       i <=
                        //           Provider.of<Alldata>(context, listen: false)
                        //               .list_of_selected_bus
                        //               .length;
                        //       i++) {
                        //     print(element.markerId.toString());
                        //     if (element.markerId.toString() ==
                        //         Provider.of<Alldata>(context, listen: false)
                        //             .list_of_selected_bus[i]
                        //             .toString()) {
                        //       want_to_delete = true;
                        //     }
                        //   }

                        //   return want_to_delete;
                        // });

                        print("after marker${newmarkers.length}");

                        return GoogleMap(
                          mapType: MapType.normal,
                          onMapCreated: (controller) {
                            mapController = controller;
                            added = true;
                          },
                          initialCameraPosition: CameraPosition(
                            zoom: 6,
                            // target: LatLng(snapshot.data!.get('letitude'),
                            //     snapshot.data!.get('longitude'))

                            target: LatLng(21.999, 71.990),
                          ),

                          markers: newmarkers,

                          //   markers: {
                          //     Marker(
                          //         markerId: MarkerId("home"),
                          //         position: LatLng(homelat, homelong),
                          //         // icon: icon,
                          //         icon:
                          //             Provider.of<Alldata>(context, listen: false)
                          //                 .homeicon),
                          //     Marker(
                          //         markerId: MarkerId("a"),
                          //         position: LatLng(snapshot.data!.get('letitude'),
                          //             snapshot.data!.get('longitude')),
                          //         icon:
                          //             Provider.of<Alldata>(context, listen: false)
                          //                 .busicon),
                          // },
                        );
                      }
                    })),

            // stack second part

            Positioned(
              bottom: 30,
              left: 8,
              child: GestureDetector(
                onTap: () {
                  print("aaaaaaaaaaaaaa");
                  setState(() {
                    show_listofbus = !show_listofbus;

                    //animation
                    //    _bus_logo_animation_conroller.forward();
                  });
                },
                child: Container(
                  child: Center(
                      child: show_listofbus
                          ? Text(
                              "GO",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "GO",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )

                      //  AnimatedBuilder(
                      //     animation: _bus_logo_animation_conroller,
                      //     builder: (context, child) {
                      //       return Icon(
                      //         Icons.directions_bus,
                      //         size: _bus_logo_animation.value * 0.3,
                      //       );
                      //     },
                      //   )
                      ),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),

            Positioned.fill(
                bottom: 5,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Visibility(
                    visible: show_listofbus,
                    child: Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Flexible(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list_of_bus.length,
                                itemBuilder: (context, index) {
                                  return list_of_bus[index];
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}
