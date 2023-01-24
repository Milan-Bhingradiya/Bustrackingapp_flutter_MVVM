import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class parentsloginscreen extends StatelessWidget {
  static late String phonenumber;
  static late String verificationid;
  late String password;
  String errormsg = "";

  Future<bool> doesPhonenumberAlreadyExist(String name) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('parents')
        .where('parentphonenumber', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      print("chheeeeeeeeeee");

      return true;
    } else {
      print("nathiiiiiiiiiiiiiiii");
      return false;
    }
  }

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
                parentsloginscreen.phonenumber = value;
              }),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "enter phone  number",
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
                bool checknumexistornot =
                    await doesPhonenumberAlreadyExist(phonenumber.toString());

                if (checknumexistornot) {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91$phonenumber',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      parentsloginscreen.verificationid = verificationId;
                      Navigator.pushNamed(context, "parentloginotpscreen");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );

                  // Navigator.pushNamed(context, "parentloginotpscreen");
                } else {
                  print("this number is not exist");
                }
                // if (user != null) {
                //   Navigator.pushNamed(context, "adminhomescreen");
                // }
              }),
              child: Text("SEND OTP"))
        ],
      ),
    );
  }
}
