import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/screens/adminlogincheck.dart';
import 'package:bustrackingapp/screens/school_admin/drivers/listofdriverscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/auth/parentsloginscreen.dart';
import 'package:bustrackingapp/screens/school_admin/auth/school_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'schooladminscreens/auth/adminloginscreen.dart';

class customclip1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

//anti clockwise
//by default p1 0,0
    path.lineTo(0, size.height); //p2
    path.lineTo(70, size.height); //p3
    path.lineTo(50, 0); //p4

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class customclip2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

//anti clockwise
//by default p1 0,0
    path.lineTo(0, size.height); //p2
    path.lineTo(50, size.height); //p3
    path.lineTo(70, 0); //p4

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class selectwhoyouarescreen extends StatefulWidget {
  const selectwhoyouarescreen({super.key});

  @override
  State<selectwhoyouarescreen> createState() => _selectwhoyouarescreenState();
}

class _selectwhoyouarescreenState extends State<selectwhoyouarescreen> {
  @override
  void initState() {
    // TODO: implement initState
    print("oookokokk");

    Provider.of<Alldata>(context, listen: false)
        .list_of_institute_dropdownitem
        .clear();
    Provider.of<Alldata>(context, listen: false)
        .fill_list_of_institute_dropdownitem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
          child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          // Colors.pink,
                          Colors.blue[800]!,

                          Colors.deepPurple[800]!,
                          // Colors.yellow
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        stops: [0.1, 0.3],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 0,
                  child: Container(
                    // color: Color(0xFF2e0a26),
                    color: Colors.white,
                  ))
            ],
          ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),

                  // Container(
                  //     height: 100,
                  //     width: 100,
                  //     child: Image.asset(
                  //       "assets/images/chooselogo.png",
                  //       fit: BoxFit.fitWidth,
                  //     )),

                  Text(
                    "Let's go",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  /////////////////////////////////////////////////////////////
                  ///
                  ///1 containter -> row-> 2 expanded -> 1st expanded for colors and circular avatar and 2nd for text....
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "driverloginscreen");
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipPath(
                                  clipper: customclip1(),
                                  child: Container(
                                    color: Color(0xFFfddc93),
                                  ),
                                ),
                                Center(
                                    child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  elevation: 10,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/selectscreen_driver_logo.png"),
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text(
                                  "I am  a",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Bus Driver",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.arrow_right_alt_outlined),
                              ]))
                        ]),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  /////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "parentsloginscreen");
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipPath(
                                  clipper: customclip2(),
                                  child: Container(
                                    color: Color(0xFFc793ff),
                                  ),
                                ),
                                Center(
                                    child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  elevation: 10,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/selectscreen_parent_logo.png"),
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text(
                                  "I am  a",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Parent Student",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.arrow_right_alt_outlined),
                              ]))
                        ]),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  //////////////////////////////////////////////////////////////////////////////////////////////

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => School_auth_screen())));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipPath(
                                  clipper: customclip1(),
                                  child: Container(
                                    color: Color(0xFF8c9efd),
                                  ),
                                ),
                                Center(
                                    child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  elevation: 10,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/selectscreen_school_logo.png"),
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text(
                                  "I am  a",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "School",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.arrow_right_alt_outlined),
                              ]))
                        ]),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  /////////////////////////////////////////////////////////////////////////////////////////

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => School_auth_screen())));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5.5,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipPath(
                                  clipper: customclip2(),
                                  child: Container(
                                    color: Color(0xFFfe9693),
                                  ),
                                ),
                                Center(
                                    child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  elevation: 10,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/selectscreen_admin_logo.png"),
                                    child: Container(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text(
                                  "I am  a",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Admin",
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.arrow_right_alt_outlined),
                              ]))
                        ]),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  ////////////////////////////////////////////////////////////////////
                  ///
                  ///
                  ///old ui
                  // GestureDetector(
                  //   onTap: () =>

                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: ((context) => parentsloginscreen()))),

                  //       Navigator.pushNamed(context, "parentwelcomescreen"),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey[900],
                  //         borderRadius: BorderRadius.circular(20)),
                  //     height: 70,
                  //     width: 250,
                  //     child: Text(
                  //       "P A R E N T",
                  //       style: TextStyle(
                  //           fontSize: 22,
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, "driverwelcomescreen");
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.circular(20)),
                  //     height: 70,
                  //     width: 250,
                  //     child: Text(
                  //       "D R I V E R",
                  //       style: TextStyle(
                  //           fontSize: 22,
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  // GestureDetector(
                  //   onTap: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: ((context) => School_auth_screen()))),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.circular(20)),
                  //     height: 70,
                  //     width: 250,
                  //     child: Text(
                  //       "School",
                  //       style: TextStyle(
                  //           fontSize: 22,
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 20,
                  // ),

                  // GestureDetector(
                  //   onTap: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: ((context) => listofdriverscreen()))),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.circular(20)),
                  //     height: 70,
                  //     width: 250,
                  //     child: Text(
                  //       "A D M I N",
                  //       style: TextStyle(
                  //           fontSize: 22,
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
