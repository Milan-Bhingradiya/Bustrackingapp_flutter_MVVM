import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'parentsloginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class parentsloginotpscreen extends StatelessWidget {
  late String otp;
  
  String errormsg = "";

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "PARENTS",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 380,
            child: Image.asset("assets/images/parentloginscreen.png"),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 310,
            decoration: BoxDecoration(
                border: Border.all(
              width: 2,
            )),
            child: TextField(
              onChanged: ((value) {
                otp = value;
              }),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "enter phone  otp",
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text("aaaaaa $errormsg"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
        
              onPressed: (() async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId:parentsloginscreen.verificationid, smsCode: otp);

    // Sign the user in (or link) with the credential
   final user = await FirebaseAuth.instance.signInWithCredential(credential);
                if (user != null) {
                  Navigator.pushNamed(context, "parentwelcomescreen");
                }
              }),
              child: Text("LOG IN"))
        ],
      ),
    );
  }
}
