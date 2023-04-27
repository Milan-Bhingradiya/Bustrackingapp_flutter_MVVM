import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class driverdrawer extends StatelessWidget {
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
                title: Text("Setting"),
                onTap: () {
                  // FirebaseAuth.instance.signOut();
                  // Navigator.pushNamed(context, "selectwhoyouarescreen");

                  //Navigator.pop(context);
                }),
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
