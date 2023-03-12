import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';

class driverprofilescreen extends StatefulWidget {
  const driverprofilescreen({super.key});

  @override
  State<driverprofilescreen> createState() => _driverprofilescreenState();
}

class _driverprofilescreenState extends State<driverprofilescreen> {
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$");

  late String driver_documentid_after_login;

  final TextEditingController drivername_controller = TextEditingController();
  final TextEditingController driverphonenumber_controller =
      TextEditingController();
  final TextEditingController driveremail_controller = TextEditingController();

  bool taptochoose = false;

  bool drivername_enable = false;
  bool driverphonenumber_enable = false;
  bool driveremail_enable = false;

  bool textfield_enable = false;

  late String? errortext_drivernamefield = null;
  late String? errortext_driverphonenumberfield = null;
  late String? errortext_driveremailfield = null;

  late String new_drivername;
  late String new_driverphonenumber;
  late String new_driveremail;

  String save_or_edit = "Edit";

  Future<void> doesPhonenumberAlreadyExist(String phonenum) async {
    print("aaaaaaaaaaaaaaaaaaaaaaa");

   // TODO: change query by new database
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('drivers')
        .where('driverphonenumber', isEqualTo: phonenum)
        .limit(1)
        .get();
    // print(result.docs.first.reference.id);
    driver_documentid_after_login = await result.docs.first.reference.id;
    Provider.of<Alldata>(context, listen: false).driver_documentid_after_login =
        driver_documentid_after_login;
  }

  void givedatatotextfield() async {
    print("bbbbbbbbbbbbbbbbbbbb");
    // final data = await FirebaseFirestore.instance
    //     .collection("drivers")
    //     .doc(driver_documentid_after_login)
    //     .get();


 // TODO: fix me  institute list
   final data =await FirebaseFirestore.instance
        .collection('main')
        .doc("main_document")
        .collection("institute_list")
        //TODO: institute ma variable avse
        .doc(Provider.of<Alldata>(context, listen: false)
              .driver_selected_institute_at_driverlogin)
        .collection("drivers")
        //TODO: arshil bhai ni jagya a variable avse
        .doc( Provider.of<Alldata>(context, listen: false)
                            .driver_name_at_driverlogin)
        .get();
    //  snapshot = data;
    //print(data['parentchildname']);
    drivername_controller.text = data['drivername'].toString();
    driverphonenumber_controller.text = data['driverphonenumber'].toString();
    driveremail_controller.text = data['email'].toString();
  }

  temp() async {
    await doesPhonenumberAlreadyExist("9016064322");
    givedatatotextfield();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bus Track")),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Form(
                  child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    Visibility(
                      visible: taptochoose,
                      child: Text("Tap To Choose"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    drivername_textfield(),
                    SizedBox(
                      height: 20,
                    ),
                    driverphonenumber_textfield(),
                    SizedBox(
                      height: 20,
                    ),
                    driveremail_textfield(),
                    SizedBox(
                      height: 20,
                    ),
                    button_edit_or_save()
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget drivername_textfield() {
    return TextField(
      controller: drivername_controller,
      enabled: textfield_enable,
      decoration: InputDecoration(
        labelText: 'Name',
        errorText: errortext_drivernamefield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        setState(() {
          new_drivername = value;
          print(new_drivername);
          print(errortext_drivernamefield);
          if (new_drivername.isEmpty) {
            errortext_drivernamefield = 'Name is required';
          } else if (new_drivername.length < 3) {
            errortext_drivernamefield = 'Name must be at least 3 characters';
          } else {
            errortext_drivernamefield = null;
          }
        });
        setState(() {});
      },
    );
  }

  Widget driverphonenumber_textfield() {
    return TextField(
      controller: driverphonenumber_controller,
      enabled: textfield_enable,
      decoration: InputDecoration(
        labelText: 'Phonenumber',
        errorText: errortext_driverphonenumberfield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        setState(() {
          new_driverphonenumber = value;
          if (new_driverphonenumber.isEmpty) {
            errortext_driverphonenumberfield = 'number is required';
          } else if (new_driverphonenumber.length < 10) {
            errortext_driverphonenumberfield = 'Enter a valid number';
          } else {
            errortext_driverphonenumberfield = null;
          }
        });
      },
    );
  }

  Widget driveremail_textfield() {
    return TextField(
      controller: driveremail_controller,
      enabled: textfield_enable,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: errortext_driveremailfield,
        //  errorText: "name is not valid",
        counterText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) {
        setState(() {
          new_driveremail = value;
          if (new_driveremail.isEmpty) {
            errortext_driveremailfield = 'Email is required';
          } else if (!_emailRegex.hasMatch(new_driveremail)) {
            errortext_driveremailfield = 'Enter a valid email';
          } else {
            errortext_driveremailfield = null;
          }
        });
      },
    );
  }

  Widget button_edit_or_save() {
    return GestureDetector(
      onTap: () {
        setState(() {
          // if if_condition is true its is go to editmode..
          if (errortext_driveremailfield == null &&
              errortext_drivernamefield == null &&
              errortext_driverphonenumberfield == null &&
              save_or_edit == "Edit") {
            setState(() {
              save_or_edit = "Save";
              textfield_enable = true;
              taptochoose = true;
            });
          }
          // if else is true it is go to again simple watch profile state
          else if (errortext_driveremailfield == null &&
              errortext_drivernamefield == null &&
              errortext_driverphonenumberfield == null) {
            setState(() {
              taptochoose = false;
              save_or_edit = "Edit";
              textfield_enable = false;

              Fluttertoast.showToast(
                msg: ' Profile Saved',
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
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
