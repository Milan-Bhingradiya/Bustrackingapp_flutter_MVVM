import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class parentdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "BUSTRACKING",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            ListTile(
              title: Text("wecomescreen"),
              onTap: () {
                Navigator.pushNamed(context, "parentwelcomescreen");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("TRACK BUS"),
              onTap: () {
                Navigator.pushNamed(context, "parentbustrackscreen");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("MY PROFILE"),
              onTap: () {
                Navigator.pushNamed(context, "parentprofilescreen");
              },
            ),
            ListTile(
              title: Text("BUSES"),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text("sign out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/");

                  //Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
