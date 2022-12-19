
import 'package:bustrackingapp/screens/studentloginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'adminscreens/adminloginscreen.dart';

class adminlogincheck extends StatelessWidget {
  const adminlogincheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return studentloginscreen();
          } else {
            return adminloginscreen();
          }
        }),
      ),
    );
  }
}
