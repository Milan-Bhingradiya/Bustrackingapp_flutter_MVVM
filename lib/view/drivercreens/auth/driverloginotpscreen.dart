import 'package:bustrackingapp/services/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class driversloginotpscreen extends StatefulWidget {
  @override
  State<driversloginotpscreen> createState() => _driversloginotpscreenState();
}

class _driversloginotpscreenState extends State<driversloginotpscreen> {
  dynamic driver_loginscreen_viewmodel = null;

  String? otp;

  final pinputcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    driver_loginscreen_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 6,
              ),
              Text(
                "Driver verification",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter the code sent to the number",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                child: Image.asset("assets/images/parentloginscreen.png"),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: size.width / 1.1,
                  decoration: BoxDecoration(),
                  child: Pinput(
                    onChanged: (value) {
                      otp = value;
                    },
                    controller: pinputcontroller,
                    length: 6,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "fill all box";
                      }
                    },
                  )),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  print(otp);
                  
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId:
                                Provider.of<Driver_loginscreen_viewmodel>(
                                        context,
                                        listen: false)
                                    .verificationid_for_otp
                                    .toString(),
                            smsCode: otp!);

                    final user = await FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .catchError((error) {
                      Fluttertoast.showToast(msg: "${error}");
                    });
                    if (user != null) {
                      await driver_loginscreen_viewmodel
                          .get_institute_doc_u_id_and_driver_doc_u_id_from_phonenumber(
                              context);
                      setState(() {});
                      print("yes otp is right");
                      Navigator.pushNamed(context,
                          "select_driverscreen_from_bottomnavigationbar");
                    } else {
                      print("not verify ");
                    }
                  } catch (e) {
                    // Fluttertoast.showToast(msg: "${e.getMessage()}");
                  }

                  // Sign the user in (or link) with the credential
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple[300],
                  ),
                  height: size.height / 14,
                  width: size.width / 1.5,
                  child: Center(
                      child: Text(
                    "Log in",
                    style: TextStyle(fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
