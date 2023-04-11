import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../trackingbus/track/screen/trackscreen.dart';

class parentdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(

                    //color: Colors.amber
                    color: Color(0xFFc793ff)),
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
              title: Text("welcomescreen"),
              onTap: () {
                Navigator.pushNamed(context, "parentwelcomescreen");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("TRACK BUS"),
              onTap: () {
                // Navigator.pushNamed(context, "select_single_or_multiple_track");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      //TODO: TODO:
                      builder: (context) => trackscreen(),
                    ));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("MY PROFILE"),
              onTap: () {
                Navigator.pushNamed(context, "parentprofilescreen");
              },
            ),
            // ListTile(
            //   title: Text("BUSES"),
            //   onTap: () {
            //     //Navigator.pop(context);
            //   },
            // ),
            ListTile(
                title: Text("sign out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "selectwhoyouarescreen");

                  //Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
