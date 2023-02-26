



// old file che

// not used now 

// in past use for ayth using email and password
// oli black and whiye main admin juni










import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class adminloginscreen extends StatefulWidget {
  @override
  State<adminloginscreen> createState() => _adminloginscreenState();
}

class _adminloginscreenState extends State<adminloginscreen> {
  late String emailid;
  late String password;
  late String? errormsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: 250,
              width: 300,
              child: Image.asset(
                "assets/images/adminlogo.png",
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                onChanged: ((value) {
                  emailid = value;
                }),
                decoration: InputDecoration(
                    hintText: "ENTER EMAIL ID",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade800)),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    hintText: "ENTER PASSWORD",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade900)),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(" $errormsg"),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (() async {
                try {
                  final user = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailid, password: password);

                  if (user != null) {
                    Navigator.pushNamed(context, "adminhomescreen");
                  }
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    errormsg = e.message.toString();
                  });
                } on Exception catch (f) {
                  print(f);
                }
              }),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.all(25),
                child: Center(
                    child: Text(
                  "LOG IN",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
