import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admindrawer extends StatelessWidget {
  const admindrawer({super.key});

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
              title: Text("SCHOOL"),
              onTap: () {
                Navigator.pushNamed(context, "selectschoolscreen");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("DRIVER"),
              onTap: () {
                Navigator.pushNamed(context, "listofdriverscreen");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("PARENTS"),
              onTap: () {
                Navigator.pushNamed(context, "listofparentsscreen");
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
