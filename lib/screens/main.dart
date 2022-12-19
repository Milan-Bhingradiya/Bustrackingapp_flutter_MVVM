import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/screens/drivercreens/drivershowmapscreen.dart';
import 'package:bustrackingapp/screens/drivercreens/driverwelcomescreen.dart';
import 'package:provider/provider.dart';
import 'package:bustrackingapp/screens/adminlogincheck.dart';
import 'package:bustrackingapp/screens/adminscreens/selectschoolscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentbustrackscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentprofilescreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentwelcomescreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentloginotpscreen.dart';
import 'package:bustrackingapp/screens/selectwhoyouarescreen.dart';
import 'package:bustrackingapp/screens/studentloginscreen.dart';
import 'package:bustrackingapp/screens/adminscreens/adminhomescreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'adminscreens/adminloginscreen.dart';
import 'adminscreens/listofdriverscreen.dart';
import 'adminscreens/listofparentsscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return ChangeNotifierProvider<Alldata>(
        create: (context) {
          return Alldata();
        },
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => selectwhoyouarescreen(),
        "adminloginscreen": (context) => adminloginscreen(),
        "studentloginscreen": (context) => studentloginscreen(),
        "adminlogincheck": (context) => adminlogincheck(),
        "adminhomescreen": (context) => adminhomescreen(),
        "selectschoolscreen": ((context) => selectschoolscreen()),
        "listofdriverscreen": ((context) => listofdriverscreen()),
        "listofparentsscreen": (context) => listofparentsscreen(),
        "parentwelcomescreen": (context) => parentwelcomescreen(),
        "parentloginotpscreen": (context) => parentsloginotpscreen(),
        "parentbustrackscreen": (context) => parentbustrackscreen(),
        "parentprofilescreen": (context) => parentprofilescreen(),

        //driver
        "driverwelcomescreen" :((context) => driverwelcomescreen()),
        "drivershowmap":(context) => drivershowmapscreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:selectwhoyouarescreen(),
    ));
  }
}
