import 'package:bustrackingapp/providers/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:bustrackingapp/screens/parentsscrens/drawer/parentdrawerwidget.dart';
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
  String save_or_edit = "Edit";
  double? parentlat = 0;
  double? parentlong = 0;
  final TextEditingController childnamecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController parentnamecontroller = TextEditingController();

  final TextEditingController parentletitudecontroller =
      TextEditingController();

  final TextEditingController parentlongitudecontroller =
      TextEditingController();

  late String? errortext_parentnamefield = null;
  late String? errortext_parentphonenumberfield = null;
  late String? errortext_parentemailfield = null;
  late String? errortext_parentchildfield = null;

  late String? errortext_parentletitude = null;
  late String? errortext_parentlongitude = null;

  late String new_parentname;
  late String new_parentchildname;
  late String new_parentphonenumber;

  late DocumentSnapshot snapshot;

  bool parent_textfield_enable = false;

  bool visible_set_location_button = false;
  bool taptochoose = false;

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

    FirebaseFirestore.instance.collection("parents").doc("darshil ").update({
      'letitude': parentlat,
      'longitude': parentlong,
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  /// document id lidhi aya thi

  // Future<void> doesPhonenumberAlreadyExist(String phonenum) async {
  //   final QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection('parents')
  //       .where('parentphonenumber', isEqualTo: phonenum)
  //       .limit(1)
  //       .get();
  //   // print(result.docs.first.reference.id);
  //   documentid = await result.docs.first.reference.id;
  //   Provider.of<Alldata>(context, listen: false).parent_document_id_afterlogin =
  //       documentid;

  // }

////////////////////////////////////////////////////////////////////////////////////////////////////
  // void givedatatotextfield() async {
  //   print("bbbbbbbbbbbbbbbbbbbb");
  //   data = await FirebaseFirestore.instance
  //       .collection("parents")
  //       .doc(documentid)
  //       .get();
  //   snapshot = data;
  //   //print(data['parentchildname']);

  //   childnamecontroller.text = data_of_Parents['parentchildname'].toString();
  //   new_parentchildname = data_of_Parents['parentchildname'].toString();

  //   phonenumbercontroller.text = data['parentphonenumber'].toString();
  //   new_parentphonenumber = data['parentphonenumber'].toString();

  //   parentnamecontroller.text = data['parentname'].toString();
  //   new_parentname = data['parentname'].toString();

  //   parentletitudecontroller.text = data['letitude'].toString();
  //   parentlat = data['letitude'];

  //   parentlongitudecontroller.text = data['longitude'].toString();
  //   parentlong = data['longitude'];
  // }

  // void temp() async {
  //   await doesPhonenumberAlreadyExist("9016064322");
  //   givedatatotextfield();
  // }

  Future getdata_from_firebase() async {
// phone num available or not
//if available than give owener name(docid)
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('parents')
        .where('parentphonenumber', isEqualTo: "9016064322")
        .limit(1)
        .get();
    // print(result.docs.first.reference.id);
    final documentid = await result.docs.first.reference.id;
    Provider.of<Alldata>(context, listen: false).parent_document_id_afterlogin =
        documentid;

//now after getting docid(parentname) get all information of parent
    final data_of_Parents = await FirebaseFirestore.instance
    .collection('main')
                        .doc("main_document")
                        .collection("institute_list")
                        .doc(Provider.of<Alldata>(context, listen: false)
                            .parent_selected_institute_at_login_at_parentlogin)
                       .collection("parents")
        .doc(Provider.of<Alldata>(context, listen: false)
                                .parent_id_login_at_parentlogin.toString())
        .get();
        
    return data_of_Parents;
  }

  // @override
  // void initState() {
  //   temp();
  // }

  @override
  Widget build(BuildContext context) {
    print("builddddddddddddddd");
    return Scaffold(
        drawer: parentdrawer(),
        appBar: AppBar(
          title: Text("edit profile"),
          backgroundColor: Color(0xFFc793ff),
        ),
        body: FutureBuilder(
          future: getdata_from_firebase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              childnamecontroller.text =
                  snapshot.data['parentchildname'].toString();
              phonenumbercontroller.text =
                  snapshot.data['parentphonenumber'].toString();
              parentnamecontroller.text =
                  snapshot.data['parentname'].toString();
              parentletitudecontroller.text =
                  snapshot.data['letitude'].toString();
              parentlongitudecontroller.text =
                  snapshot.data['longitude'].toString();

              new_parentchildname = snapshot.data['parentchildname'].toString();
              new_parentphonenumber =
                  snapshot.data['parentphonenumber'].toString();
              new_parentname = snapshot.data['parentname'].toString();
              parentlat = snapshot.data['letitude'];
              parentlong = snapshot.data['longitude'];
              return Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                          "WELCOME  ${new_parentname.toString().toUpperCase()}  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 50,
                      ),
                      Visibility(
                        visible: taptochoose,
                        child: Text("Tap To Choose"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      parentname_textfield(snapshot),
                      SizedBox(
                        height: 15,
                      ),
                      parentchildname_textfield(),
                      SizedBox(
                        height: 15,
                      ),
                      parentphonenumber_textfield(),
                      SizedBox(
                        height: 15,
                      ),
                      parentletitude_textfield(),
                      SizedBox(
                        height: 15,
                      ),
                      parentlongitude_textfield(),
                      SizedBox(
                        height: 15,
                      ),
                      set_lat_long_button(),
                      SizedBox(
                        height: 15,
                      ),
                      parentbutton_edit_or_save()
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget parentname_textfield(snapshot) {
    return TextField(
      controller: parentnamecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Name',
        errorText: errortext_parentnamefield,
        //  errorText: "name is not valid",
        // counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        new_parentname = value;

        if (new_parentname.isEmpty) {
          errortext_parentnamefield = 'Name is required';
        } else if (new_parentname.length < 3) {
          errortext_parentnamefield = 'Name must be at least 3 characters';
        } else {
          errortext_parentnamefield = null;
        }
      },
    );
  }

  Widget parentchildname_textfield() {
    return TextField(
      autofocus: true,
      controller: childnamecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Child Name',
        errorText: errortext_parentchildfield,
        //  errorText: "name is not valid",
        // counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        new_parentchildname = value;

        if (new_parentchildname.isEmpty) {
          errortext_parentchildfield = 'Name is required';
        } else if (new_parentchildname.length < 3) {
          errortext_parentchildfield = 'Name must be at least 3 characters';
        } else {
          errortext_parentchildfield = null;
        }
      },
    );
  }

  Widget parentphonenumber_textfield() {
    return TextField(
      controller: phonenumbercontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Phonenumber',
        errorText: errortext_parentphonenumberfield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        new_parentphonenumber = value;
        if (new_parentphonenumber.isEmpty) {
          errortext_parentphonenumberfield = 'number is required';
        } else if (new_parentphonenumber.length < 10) {
          errortext_parentphonenumberfield = 'Enter a valid number';
        } else {
          errortext_parentphonenumberfield = null;
        }
      },
    );
  }

  Widget parentletitude_textfield() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: parentletitudecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Pick Place letitude',
        errorText: errortext_parentletitude,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        parentlat = double.parse(value);
        if (parentlat == 0) {
          errortext_parentletitude = 'number is required';
        } else {
          errortext_parentletitude = null;
        }
      },
    );
  }

  Widget parentlongitude_textfield() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: parentlongitudecontroller,
      enabled: parent_textfield_enable,
      decoration: InputDecoration(
        labelText: 'Pick Place longitude',
        errorText: errortext_parentletitude,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        parentlong = double.parse(value);
        if (parentlong == 0) {
          errortext_parentlongitude = 'number is required';
        } else {
          errortext_parentlongitude = null;
        }
      },
    );
  }

  Widget set_lat_long_button() {
    return Visibility(
      visible: visible_set_location_button,
      child: GestureDetector(
        onTap: () {
          setlocation();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          alignment: Alignment.center,
          height: 40,
          width: 300,
          child: Text(
            "set my current location",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget parentbutton_edit_or_save() {
    return GestureDetector(
      onTap: () {
        setState(() {
          // if if_condition is true its is go to editmode..
          if (errortext_parentnamefield == null &&
              errortext_parentchildfield == null &&
              errortext_parentemailfield == null &&
              errortext_parentphonenumberfield == null &&
              errortext_parentletitude == null &&
              errortext_parentlongitude == null &&
              save_or_edit == "Edit") {
            setState(() {
              save_or_edit = "Save";
              parent_textfield_enable = true;
              visible_set_location_button = true;
              taptochoose = true;
            });
          }
          // if else is true it is go to again simple watch profile state
          else if (errortext_parentnamefield == null &&
              errortext_parentchildfield == null &&
              errortext_parentemailfield == null &&
              errortext_parentphonenumberfield == null &&
              errortext_parentletitude == null &&
              errortext_parentlongitude == null) {
            setState(() {
              taptochoose = false;
              save_or_edit = "Edit";
              parent_textfield_enable = false;
              visible_set_location_button = false;

////////////////////////////////////////////////

              FirebaseFirestore.instance
                  .collection("parents")
                  .doc("darshil ")
                  .update({
                "parentname": new_parentname,
                "parentchildname": new_parentchildname,
                "parentphonenumber": new_parentphonenumber,
                'letitude': parentlat,
                'longitude': parentlong,
              }).then(((value) {
                Fluttertoast.showToast(
                  msg: ' Profile Saved',
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }));
            });
          }

          print("touch");
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 40,
        width: 90,
        child: Center(child: Text(save_or_edit)),
      ),
    );
  }
}
