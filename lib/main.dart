import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/admin/add_school.dart';
import 'package:bustrackingapp/view/admin/admin.dart';
import 'package:bustrackingapp/view/admin/auth/admin_login.dart';

import 'package:bustrackingapp/view/drivercreens/auth/driverloginscreen.dart';
import 'package:bustrackingapp/view/drivercreens/select_driverscreen_from_bottomnavigationbar.dart';
import 'package:bustrackingapp/view/parentsscrens/auth/parentsloginscreen.dart';
import 'package:bustrackingapp/view/parentsscrens/select_parentscreen_from_bottomnavigationbar.dart';
import 'package:bustrackingapp/view/school_admin/buses/list_of_bus_screen.dart';
import 'package:bustrackingapp/view/school_admin/parents/addnewparents_screen.dart';
import 'package:bustrackingapp/view/drivercreens/profile/driverprofilescreen.dart';
import 'package:bustrackingapp/view/drivercreens/home/driverwelcomescreen.dart';
import 'package:bustrackingapp/view/drivercreens/show_map/map_for_driver.dart';
import 'package:bustrackingapp/view/splashscreen/splashscreen.dart';

import 'package:bustrackingapp/view_model/admin/admin_addinstitute_viewmodel.dart';
import 'package:bustrackingapp/view_model/admin/admin_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/driver/driver_bottomnavigationbar_viewmodel.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/driver/driver_profilescreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/driver/driver_showmapscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/driver/driver_welcomescreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';

import 'package:bustrackingapp/view_model/parents/parent_profilescreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_bottomnavigationbar_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_selectdriver_for_chat_screen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_trackbusscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_bus_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_driver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_parent_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:bustrackingapp/view/school_admin/school_address_screen/selectschoolscreen.dart';
import 'package:bustrackingapp/view/parentsscrens/profile/parentprofilescreen.dart';
import 'package:bustrackingapp/view/parentsscrens/homescreen/parentwelcomescreen.dart';
import 'package:bustrackingapp/view/parentsscrens/auth/parentloginotpscreen.dart';
import 'package:bustrackingapp/view/selectwhoyouarescreen.dart';
import 'package:bustrackingapp/view/school_admin/adminhomescreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/school_admin/drivers/listofdriverscreen.dart';
import 'view/school_admin/parents/listofparentsscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await dotenv.load(fileName: ".env" );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        //  ChangeNotifierProvider<Alldata>(
        //     create: (context) {
        //       return Alldata();
        //     },
        MultiProvider(
            providers: [
          //driver ke
          ListenableProvider<Driver_loginscreen_viewmodel>(
              create: (cntext) => Driver_loginscreen_viewmodel()),
          ListenableProvider<Alldata>(create: (cntext) => Alldata()),

          ChangeNotifierProvider<Driver_profilescreen_viewmodel>(
              create: (create) => Driver_profilescreen_viewmodel()),
          ChangeNotifierProvider<Driver_welcomescreen_viewmodel>(
              create: (create) => Driver_welcomescreen_viewmodel()),
          ChangeNotifierProvider<Driver_showmapscreen_viewmodel>(
              create: (create) => Driver_showmapscreen_viewmodel()),
              ChangeNotifierProvider<Driver_bottomnavigationbar_viewmodel>(
              create: (create) => Driver_bottomnavigationbar_viewmodel()),
              

          //parent ke
          ChangeNotifierProvider<Parent_loginscreen_viewmodel>(
              create: (create) => Parent_loginscreen_viewmodel()),
          ChangeNotifierProvider<Parent_profilescreen_viewmodel>(
              create: (create) => Parent_profilescreen_viewmodel()),
          ChangeNotifierProvider<Parent_trackbusscreen_viewmodel>(
              create: (create) => Parent_trackbusscreen_viewmodel()),
          ChangeNotifierProvider<
                  Parent_bottomnavigationbar_viewmodel>(
              create: (create) =>
                  Parent_bottomnavigationbar_viewmodel()),
   ChangeNotifierProvider<
                  Parent_selectdriver_for_chat_screen_viewmodel>(
              create: (create) =>
                  Parent_selectdriver_for_chat_screen_viewmodel()),
          //schooladmin

          ChangeNotifierProvider<Schooladmin_loginscreen_viewmodel>(
              create: (create) => Schooladmin_loginscreen_viewmodel()),
          ChangeNotifierProvider<Schooladmin_driver_viewmodel>(
              create: (create) => Schooladmin_driver_viewmodel()),
          ChangeNotifierProvider<Schooladmin_parent_viewmodel>(
              create: (create) => Schooladmin_parent_viewmodel()),
          ChangeNotifierProvider<Schooladmin_bus_viewmodel>(
              create: (create) => Schooladmin_bus_viewmodel()),

          //admin
          ChangeNotifierProvider<Admin_loginscreen_viewmodel>(
              create: (create) => Admin_loginscreen_viewmodel()),
          ChangeNotifierProvider<Admin_addinstitute_viewmodel>(
              create: (create) => Admin_addinstitute_viewmodel()),
        ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: "/",
              routes: {
                "/": (context) => splashscreen(),
                "selectwhoyouarescreen": (context) => selectwhoyouarescreen(),
                "adminhomescreen": (context) => adminhomescreen(),
                "selectschoolscreen": ((context) => selectschoolscreen()),
                "listofdriverscreen": ((context) => listofdriverscreen()),
                "listofparentsscreen": (context) => listofparentsscreen(),
                "parentwelcomescreen": (context) => parentwelcomescreen(),
                "parentloginotpscreen": (context) => parentsloginotpscreen(),
                "select_parentscreen_from_bottomnavigationbar": (context) =>
                    select_parentscreen_from_bottomnavigationbar(),

                "parentprofilescreen": (context) => parentprofilescreen(),
                "parentsloginscreen": (context) => parentsloginscreen(),
                //driver
                "driverwelcomescreen": ((context) => driverwelcomescreen()),
                "mapfordriver": (context) => mapfordriver(),
                "driverprofilescreen": (context) => driverprofilescreen(),
               "select_driverscreen_from_bottomnavigationbar": (context) =>
                    select_driverscreen_from_bottomnavigationbar(),


                //buses
                "listofbusscreen": (context) => listofbusscreen(),
                "addnewparents_screen": (context) => addnewparents_screen(),
                "driverloginscreen": (context) => driverloginscreen(),

                //admin
                "admin": (context) => admin(),
                "add_school": (context) => add_school(),
                "admin_login": (context) => admin_login(),
              },
              title: 'Flutter Demo',

              // home:selectwhoyouarescreen(),
            ));
  }
}
