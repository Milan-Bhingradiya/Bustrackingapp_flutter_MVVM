import 'package:bustrackingapp/data/network_services/parent_services/parent_firestore_service.dart';
import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'parentsloginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class parentsloginotpscreen extends StatefulWidget {
  @override
  State<parentsloginotpscreen> createState() => _parentsloginotpscreenState();
}

class _parentsloginotpscreenState extends State<parentsloginotpscreen> {
  dynamic parent_otpscreen_viewmodel = null;
  dynamic parent_loginscreen_viewmodel = null;
  

  String? otp;

  String errormsg = "";

  final pinputcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   
          parent_loginscreen_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);
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
                "Parent verification",
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
              Text("aaaaaa $errormsg"),
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
                                Provider.of<Parent_loginscreen_viewmodel>(
                                        context,
                                        listen: false)
                                    .verificationid_for_otp
                                    .toString(),
                            smsCode: otp!);

                    final user = await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    if (user != null) {
                      await parent_otpscreen_viewmodel
                          .get_institutename_and_parentname_from_phonenumber(
                              context, parent_loginscreen_viewmodel.parentphonenumber);
                              setState(() {
                                
                              });

                      Navigator.pushNamed(context, "parentwelcomescreen");
                    }
                  } catch (e) {
                    print("auh error ${e}");
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
