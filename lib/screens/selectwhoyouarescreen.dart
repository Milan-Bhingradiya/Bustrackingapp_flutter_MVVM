import 'package:bustrackingapp/screens/adminlogincheck.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentsloginscreen.dart';
import 'package:flutter/material.dart';

import 'adminscreens/adminloginscreen.dart';

class selectwhoyouarescreen extends StatelessWidget {
  const selectwhoyouarescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/images/chooselogo.png",
                  fit: BoxFit.fitWidth,
                )),
            // Text(
            //   "select who you are.. ",
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            // ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () =>

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => parentsloginscreen()))),

                  Navigator.pushNamed(context, "parentprofilescreen"),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20)),
                height: 70,
                width: 250,
                child: Text(
                  "P A R E N T",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "driverwelcomescreen");
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                height: 70,
                width: 250,
                child: Text(
                  "D R I V E R",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => adminloginscreen()))),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                height: 70,
                width: 250,
                child: Text(
                  "A D M I N",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
