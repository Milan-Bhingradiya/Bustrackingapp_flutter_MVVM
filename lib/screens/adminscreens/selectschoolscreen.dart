import 'package:flutter/material.dart';
//import 'package:geocoder/services/base.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geocoder/geocoder.dart';

import 'admindrawerwidget.dart';

import 'package:geocoding/geocoding.dart';

class selectschoolscreen extends StatefulWidget {
  const selectschoolscreen({super.key});

  @override
  State<selectschoolscreen> createState() => _selectschoolscreenState();
}

class _selectschoolscreenState extends State<selectschoolscreen> {
  late double lat;
  late double log;
  late String address;
  bool check = false;
  var text = TextEditingController();

  void findaddress() async {
    // final address2 = await Geocoding .local
    //     .findAddressesFromCoordinates(Coordinates(lat, log));
    // var first = address2.first;

    // using geocoding pckg..
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, log);

    setState(() {
      // address = first.addressLine;
      // text.text = first.addressLine;
      address = placemarks.first.country!;
      text.text=placemarks.first.country!;
    });
    // print("aaaaaaaaaaaaaaaaaaaaaaaa $address");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("select school on map"),
      ),
      drawer: admindrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Icon(Icons.school),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: TextField(
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: TextField(
              // onChanged: (value) {
              //   print(text.text);
              // },
              controller: text,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: GoogleMap(
                  markers: check
                      ? {
                          Marker(
                              markerId: MarkerId('m'),
                              position: LatLng(lat, log))
                        }
                      : {
                          Marker(
                              markerId: MarkerId('m'), position: LatLng(21, 71))
                        },
                  onTap: ((argument) {
                    setState(() {
                      lat = argument.latitude;
                      log = argument.longitude;
                      check = true;
                    });
                    findaddress();

                    print(argument);
                  }),
                  initialCameraPosition:
                      CameraPosition(target: LatLng(21, 71))),
            ),
          )
        ],
      ),
    );
  }
}
