import 'dart:ffi';

import 'package:bustrackingapp/screens/parentsscrens/trackingbus/multiple_track/multiplemarker.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/single_track/parentbustrackscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/track/screen/trackscreen.dart';
import 'package:bustrackingapp/screens/parentsscrens/trackingbus/track/widgets/bus_and_num.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';

enum loginorsignup { login, signup }

class select_single_or_multiple_track extends StatefulWidget {
  const select_single_or_multiple_track({super.key});

  @override
  State<select_single_or_multiple_track> createState() =>
      _select_single_or_multiple_trackState();
}

class _select_single_or_multiple_trackState
    extends State<select_single_or_multiple_track> {
  late final QuerySnapshot q;

  List<String> listof_all_documentid = [];

  List<DropdownMenuItem> listof_dropdownmenuitem = [];

  int? a;

  String dropdownvalue = "temp";

  //late QuerySnapshot querySnapshot1;
  int? num_of__document;
  loginorsignup loginsignupobj = loginorsignup.login;

  bool visible_dropdown = false;

  Future<List<String>> create_listof_all_documentid() async {
    print("first callllllllllllllll");
    q = await FirebaseFirestore.instance
        .collection('drivers')
        // .doc('ramu3')
        .get();

    q.docs.forEach((doc) {
      listof_all_documentid.add(doc.id.toString());
    });
    num_of__document = q.docs.length;
    dropdownvalue = listof_all_documentid.first;
    return listof_all_documentid;
  }

  void create_listof_dropdownmenuitem() {
    print("second callll");
    print(listof_all_documentid);
    for (var i = 0; i < listof_all_documentid.length; i++) {
      listof_dropdownmenuitem.add(DropdownMenuItem(
          child: Text(listof_all_documentid[i].toString()),
          value: (listof_all_documentid[i].toString())));
    }
    setState(() {});
  }

  temp() async {
    create_listof_all_documentid().then((value) {
      create_listof_dropdownmenuitem();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp();
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    /// use material app beacause this error ::::::: Exception caught by widgets library ═══════════════════════════════════ Incorrect use of ParentDataWidget. ════════════════════════════════════
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        //TODO: TODO:
                        builder: (context) => trackscreen(),
                      ));
                },
                child: Container(
                  color: Colors.black,
                  height: 100,
                  width: 300,
                )),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {

                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => multiplemarker()));

              //  Navigator.pushNamed(context, "parent_multiple_marker");
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(13.0)),
                height: 70,
                width: 300,
                child: Row(children: [
                  Container(
                      height: 60,
                      width: 90,
                      child: Image.asset("assets/images/single_bus.png")),
                  Center(
                      child: Text(
                    "Track All Buses",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
                ]),
              ),
            ),
            Text(
                "......................................................................................................."),
            // Column(children: listofradtiotile)

            Text(listof_all_documentid.length.toString()),
            GestureDetector(
              onTap: () {
                setState(() {
                  visible_dropdown = !visible_dropdown;
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(13.0)),
                  height: 70,
                  width: 300,
                  child: Row(
                    children: [
                      Container(
                          height: 80,
                          width: 90,
                          child: Image.asset("assets/images/multiple_bus.png")),
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                          child: Text(
                        "Track Only One Bus",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      )),
                    ],
                  )),
            ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// select as radiobutton code

            // Visibility(
            //   visible: visible_listviewbuilder,
            //   child: Container(
            //     height: 200,
            //     child: Expanded(
            //       child: ListView.builder(
            //         itemCount: listof_all_documentid.length,
            //         itemBuilder: (context, index) {
            //           return Container(
            //               height: 35,
            //               child: Row(
            //                 children: [
            //                   SizedBox(
            //                     width: 110,
            //                   ),
            //                   Radio(
            //                     value: index,
            //                     groupValue: a,
            //                     onChanged: (value) {
            //                       setState(() {
            //                         // print("touch");
            //                         // print(value);
            //                         //  print(a);
            //                         a = value;
            //                         //print(a);
            //                       });
            //                     },
            //                   ),
            //                   Text(listof_all_documentid[index].toString()),
            //                 ],
            //               ));
            //         },
            //       ),
            //     ),
            //   ),
            // ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            SizedBox(
              height: 20,
            ),

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
            Visibility(
              visible: visible_dropdown,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(13.0)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    /////////////////////////////////////////////
                    Material(
                      elevation: 20,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: 250,
                        child: DropdownButton(
                          isExpanded: true,
                          iconSize: 40,
                          value: dropdownvalue,
                          items: listof_dropdownmenuitem,
                          onChanged: (value) {
                            dropdownvalue = value;

                            setState(() {
                              Provider.of<Alldata>(context, listen: false)
                                  .track_single_bus_document_id = dropdownvalue;
                            });
                          },
                        ),
                      ),
                    ),

                    //////////////////////////////////////////////////////////
                    SizedBox(
                      height: 30,
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "parentbustrackscreen");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 128, 128, 128),
                            borderRadius: BorderRadius.circular(13.0)),
                        height: 50,
                        width: 200,
                        child:
                            Center(child: Text("LETS GO Track only one Bus")),
                      ),
                    ),
                    ////////////////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )

            //////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
          ],
        ),
      )),
    );
  }
}
