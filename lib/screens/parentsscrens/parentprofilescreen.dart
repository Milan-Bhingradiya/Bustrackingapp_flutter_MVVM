import 'package:bustrackingapp/providers/provider.dart';
import 'package:location/location.dart';
import 'package:bustrackingapp/screens/parentsscrens/parentdrawerwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class parentprofilescreen extends StatefulWidget {
  @override
  State<parentprofilescreen> createState() => _parentprofilescreenState();
}

class _parentprofilescreenState extends State<parentprofilescreen> {
  double? parentlat = 0;
  double? parentlong = 0;
  final TextEditingController childnamecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController parentnamecontroller = TextEditingController();

  final TextEditingController parentletitudecontroller =
      TextEditingController();

  final TextEditingController parentlongitudecontroller =
      TextEditingController();
  late DocumentSnapshot snapshot;

  late String documentid;

  void setlocation() async {
    // LocationPermission permission;
    // permission = await LocationPermissio.requestPermission();

    Location l = Location();

    await l.requestPermission();
    LocationData parentlocation = await l.getLocation();
    parentlat = parentlocation.latitude;
    parentlong = parentlocation.longitude;
    parentletitudecontroller.text = parentlocation.latitude.toString();
    parentlongitudecontroller.text = parentlocation.longitude.toString();

    FirebaseFirestore.instance.collection("parents").doc(documentid).update({
      'letitude': parentlat,
      'longitude': parentlong,
    });
  }

  Future<void> doesPhonenumberAlreadyExist(String phonenum) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('parents')
        .where('parentphonenumber', isEqualTo: phonenum)
        .limit(1)
        .get();
    // print(result.docs.first.reference.id);
    documentid = await result.docs.first.reference.id;
    Provider.of<Alldata>(context,listen: false).parent_document_id_afterlogin=documentid ; 
    print("aaaaaaaaaaaaaaaaaaaaaa");
    childnamecontroller.text = "aaaaaaaaa";
  }

  void givedatatotextfield() async {
    print("bbbbbbbbbbbbbbbbbbbb");
    final data = await FirebaseFirestore.instance
        .collection("parents")
        .doc(documentid)
        .get();
    snapshot = data;
    //print(data['parentchildname']);
    childnamecontroller.text = data['parentchildname'].toString();
    phonenumbercontroller.text = data['parentphonenumber'].toString();
    parentnamecontroller.text = data['parentname'].toString();
    parentletitudecontroller.text = data['letitude'].toString();
    parentlongitudecontroller.text = data['longitude'].toString();
  }

  void temp() async {
    await doesPhonenumberAlreadyExist("9016064322");
    givedatatotextfield();
  }

  @override
  void initState() {
    temp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: parentdrawer(),
        appBar: AppBar(title: Text("edit profile")),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "PROFILE ",
                style: TextStyle(fontSize: 50),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    "NAME",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: parentnamecontroller,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    "child name",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: childnamecontroller,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    "PHONE NUM :",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: phonenumbercontroller,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    "letitude",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: parentletitudecontroller,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    "longitude",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: parentlongitudecontroller,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  setlocation();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  color: Colors.blue[300],
                  child: Text(
                    "set my current location",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
