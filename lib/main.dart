import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/screens/drivercreens/auth/driverloginscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/auth/parentsloginscreen.dart';
import 'package:bustrackingapp/screens/school_admin/buses/list_of_bus_screen.dart';
import 'package:bustrackingapp/screens/school_admin/parents/addnewparents_screen.dart';
import 'package:bustrackingapp/screens/drivercreens/profile/driverprofilescreen.dart';
import 'package:bustrackingapp/screens/drivercreens/show_map/drivershowmapscreen.dart';
import 'package:bustrackingapp/screens/drivercreens/driverwelcomescreen.dart';
import 'package:bustrackingapp/screens/drivercreens/show_map/map_for_driver.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/multiple_track/multiplemarker.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/select_single_or_multiple_track.dart';
import 'package:bustrackingapp/screens/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:bustrackingapp/screens/adminlogincheck.dart';
import 'package:bustrackingapp/screens/school_admin/school_address_screen/selectschoolscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/single_track/parentbustrackscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/profile/parentprofilescreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentwelcomescreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/auth/parentloginotpscreen.dart';
import 'package:bustrackingapp/screens/selectwhoyouarescreen.dart';
import 'package:bustrackingapp/screens/studentloginscreen.dart';
import 'package:bustrackingapp/screens/school_admin/adminhomescreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/schooladminscreens/auth/adminloginscreen.dart';
import 'screens/school_admin/drivers/listofdriverscreen.dart';
import 'screens/school_admin/parents/listofparentsscreen.dart';

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
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => splashscreen(),
         "selectwhoyouarescreen": (context) => selectwhoyouarescreen(),
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
        "parentsloginscreen" : (context) => parentsloginscreen(),

        //driver
        "driverwelcomescreen" :((context) => driverwelcomescreen()),
        "drivershowmap":(context) => drivershowmapscreen(),


        "parent_multiple_marker":(context) => multiplemarker(),
        "select_single_or_multiple_track":(context) => select_single_or_multiple_track(),
        "mapfordriver":(context) => mapfordriver(),
        "driverprofilescreen":(context) => driverprofilescreen(),


        //buses
        "listofbusscreen":(context)=>listofbusscreen(),


        "addnewparents_screen":(context)=>addnewparents_screen(),


        "driverloginscreen" :(context) => driverloginscreen(),
      },
      title: 'Flutter Demo',
     
      // home:selectwhoyouarescreen(),
    ));
  }
}
