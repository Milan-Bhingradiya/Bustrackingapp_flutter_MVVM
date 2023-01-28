import 'dart:async';
import 'dart:convert';

//import 'dart:html';
//import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/multiple_track/multiplemarker.dart';
import 'package:bustrackingapp/screens/parentsscrens/drawer/parentdrawerwidget.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/select_single_or_multiple_track.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  io.File? final_img;

  final storageRef = FirebaseStorage.instance.ref();
  Future<void> select_img() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        final_img = io.File(image.path);
      }
    });
  }

  Future<void> uploadPic() async {
    String url = "";
    try {
      //  url = await mountainImagesRef.getDownloadURL();
      final ref = storageRef.child("images/first");
      ref.putFile(final_img!);
    
    } catch (e) {
      print(e);
    }
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
                  select_img();
                },
                child: CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        final_img == null ? null : FileImage(final_img!),
                    child: final_img == null
                        ? Container(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                              Text("select profile")
                            ],
                          ))
                        : null)),

            GestureDetector(
              onTap: () async {
                await uploadPic().then((value) {
                  Fluttertoast.showToast(msg: "your profile has been updated");
                });
                //  print(url_of_img);
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
