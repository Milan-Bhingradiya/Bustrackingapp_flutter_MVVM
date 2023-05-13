import 'package:bustrackingapp/view/school_admin/drawer/admindrawerwidget.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_homescreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class adminhomescreen extends StatefulWidget {
  @override
  State<adminhomescreen> createState() => _adminhomescreenState();
}

class _adminhomescreenState extends State<adminhomescreen> {
  dynamic schooladmin_homescreen_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schooladmin_homescreen_viewmodel =
        Provider.of<Schooladmin_homescreen_viewmodel>(context, listen: false);
    schooladmin_homescreen_viewmodel.set_num_of_bus_parent_driver(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final schooladmin_homescreen_viewmodel2 =
        Provider.of<Schooladmin_homescreen_viewmodel>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFF76a6f0),
          elevation: 0,
        ),
        drawer: admindrawer(),
        body: Stack(
          children: [
            //layer 1
            Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Color(0xFF76a6f0),
                    )),
                Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.white,
                    ))
              ],
            ),
            //layer 2
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "School Dashboard",
                  style: TextStyle(
                      fontFamily: "Playfair Display",
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: size.height / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "listofbusscreen");
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius:
                              BorderRadius.circular(20.0), //<-- SEE HERE
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: size.height / 3.5,
                          width: size.width / 2.5,

                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/school_admin_img/bus.png",
                                height: size.height / 5,
                                width: size.width / 2.7,
                              ),
                              Text(
                                "We have ${schooladmin_homescreen_viewmodel2.num_of_buses} Buses",
                                style: TextStyle(
                                    fontFamily: "Playfair Display",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          // color: Colors.amber,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "listofdriverscreen");
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius:
                              BorderRadius.circular(20.0), //<-- SEE HERE
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: size.height / 3.5,
                          width: size.width / 2.5,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/school_admin_img/driver.png",
                                height: size.height / 5,
                                width: size.width / 2.7,
                              ),
                              Text(
                                "We have  ${schooladmin_homescreen_viewmodel2.num_of_drivers} Drivers",
                                style: TextStyle(
                                    fontFamily: "Playfair Display",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          // color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),

                ////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "listofparentsscreen");
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius:
                              BorderRadius.circular(20.0), //<-- SEE HERE
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: size.height / 3.5,
                          width: size.width / 2.5,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/school_admin_img/parent.png",
                                height: size.height / 5,
                                width: size.width / 2.7,
                              ),
                              Text(
                                "We have  ${schooladmin_homescreen_viewmodel2.num_of_parents}  Parents",
                                style: TextStyle(
                                    fontFamily: "Playfair Display",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //       color: Colors.black,
                    //     ),
                    //     borderRadius:
                    //         BorderRadius.circular(20.0), //<-- SEE HERE
                    //   ),
                    //   child: Container(
                    //     margin: EdgeInsets.all(10),
                    //     height: size.height / 3.5,
                    //     width: size.width / 2.5,
                    //     child: Column(
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/school_admin_img/bus.png",
                    //           height: size.height / 5,
                    //           width: size.width / 2.7,
                    //         ),
                    //         Text(
                    //           "We have  Buses",
                    //           style: TextStyle(
                    //               fontFamily: "Playfair Display",
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.bold),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class CustomShapeClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height / 4.25);
    var firstControlPoint = new Offset(size.width / 4, size.height / 3);
    var firstEndPoint = new Offset(size.width / 2, size.height / 3 - 60);
    var secondControlPoint =
        new Offset(size.width - (size.width / 4), size.height / 4 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 3 - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
