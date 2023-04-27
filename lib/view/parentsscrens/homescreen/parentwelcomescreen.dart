import 'dart:async';
import 'dart:convert';

//import 'dart:html';
//import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/view/parentsscrens/drawer/parentdrawerwidget.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';

class parentwelcomescreen extends StatefulWidget {
  const parentwelcomescreen({super.key});

  @override
  State<parentwelcomescreen> createState() => _parentwelcomescreenState();
}

class _parentwelcomescreenState extends State<parentwelcomescreen> {
  dynamic parent_loginscreen_viewmodel = null;
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

    parent_loginscreen_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);

    print(
        "pareeeeeeeeeeeeent welcome : ${parent_loginscreen_viewmodel.parent_entered_name_at_login}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFffffff),
        // appBar: AppBar(
        //   title: Text("parent home screen"),
        //   backgroundColor: Color(0xFFc793ff),
        // ),
        drawer: parentdrawer(),
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(child: Image.asset("assets/images/parent_welcome.png"))
          ],
        ));
  }
}
