import 'dart:async';
//import 'dart:html';
//import 'dart:html';
import 'dart:io';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/multiple_track/multiplemarker.dart';
import 'package:bustrackingapp/screens/parentsscrens/drawer/parentdrawerwidget.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/select_single_or_multiple_track.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/provider.dart';

class parentwelcomescreen extends StatefulWidget {
  const parentwelcomescreen({super.key});

  @override
  State<parentwelcomescreen> createState() => _parentwelcomescreenState();
}

class _parentwelcomescreenState extends State<parentwelcomescreen> {

  File? final_img;
  late final imaegtemporary;

//   Future uploadfile() async {
//  // final file = File( image.path);
//   }

  select_img() async {
    
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
   final imaegtemporary = File(image.path);
    }

    setState(() {
      this.final_img = imaegtemporary;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // here i check if already i assign icon to variable
    //then bypass assign icon to bus
    Provider.of<Alldata>(context, listen: false).make_and_assign_icon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("parent home screen")),
      drawer: parentdrawer(),
      body: Container(
        child: Column(
          children: [
            // for checking i am able to make stream or not just for example
            GestureDetector(
              onTap: () async {
                print("touch");
                // List<Placemark> placemarks = await placemarkFromCoordinates(
                //     21.22461083368087, 72.77901540143989);
                // print(placemarks.last.street);

                select_img();

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => select_single_or_multiple_track())));

                // print(DocumentSnapshot.);
              },
              child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.amber,
                  child: (final_img != null)
                      ? Image.file(
                          final_img!,
                          height: 200,
                          width: 200,
                        )
                      : Container()),
            )
          ],
        ),
      ),
    );
  }
}
