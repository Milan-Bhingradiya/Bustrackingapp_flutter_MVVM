import 'package:bustrackingapp/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class driverloginscreen extends StatefulWidget {
  static late String phonenumber;
  static late String verificationid;

  @override
  State<driverloginscreen> createState() => _driverloginscreenState();
}

class _driverloginscreenState extends State<driverloginscreen> {
  String dropdownvalue = "";

  TextEditingController mobile_number_textbox_controller =
      TextEditingController();
  TextEditingController id_textbox_controller = TextEditingController();
  TextEditingController password_textbox_controller = TextEditingController();
  late String password;

  String errormsg = "";

  bool email_or_phone = false;

//TODO: change here
  Future<bool> doesPhonenumberAlreadyExist(String name) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('parents')
        .where('parentphonenumber', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      print("chheeeeeeeeeee");

      return true;
    } else {
      print("nathiiiiiiiiiiiiiiii");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<Alldata>(context, listen: false)
        .list_of_institute_dropdownitem
        .length);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "DRIVER",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 30,
              ),
              if (email_or_phone)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: mobile_number_textbox_controller,
                    keyboardType: TextInputType.phone,
                    onChanged: ((value) {}),
                    decoration: InputDecoration(
                        hintText: "Enter Mobie Number",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade800)),
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
              if (!email_or_phone)
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(8),
                          underline: SizedBox(),
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          hint: Text("select institute"),
                          value: dropdownvalue == "" || dropdownvalue == null
                              ? null
                              : dropdownvalue,
                          items: Provider.of<Alldata>(context, listen: false)
                              .list_of_institute_dropdownitem,
                          onChanged: (value) {
                            setState(() {
                              dropdownvalue = value;
                            });
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      height: 55,
                      width: double.infinity,
                    )),
              SizedBox(
                height: 5,
              ),
              if (!email_or_phone) id_textbox(id_textbox_controller),
              if (!email_or_phone)
                password_textbox(password_textbox_controller),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: (() async {
                    //     bool checknumexistornot =
                    //     await doesPhonenumberAlreadyExist(phonenumber.toString());

//TODO:

// login using mobbile number/////////
                    if (email_or_phone) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '+91${mobile_number_textbox_controller.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Provider.of<Alldata>(context, listen: false)
                              .parent_login_verification_id = verificationId;
                          Navigator.pushNamed(context, "parentloginotpscreen");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                      Navigator.pushNamed(context, "parentloginotpscreen");
                    } else {
                      print("this number is not exist");
                    }
                    // if (user != null) {
                    //   Navigator.pushNamed(context, "adminhomescreen");
                    // }

//TODO: logic of  auth with pass

                    var get_password_from_firebase;
                    var docSnapshot;
                    if (email_or_phone == false) {
                      if (dropdownvalue == "" ||
                          dropdownvalue == null ||
                          id_textbox_controller.text == null ||
                          id_textbox_controller.text == "") {
                      } else {
                        print("parent login getting password query fired");
                        docSnapshot = await FirebaseFirestore.instance
                            .collection("main")
                            .doc("main_document")
                            .collection("institute_list")
                            .doc("$dropdownvalue")
                            .collection("drivers")
                            .doc(id_textbox_controller.text.toString())
                            .get();
                      }

                      if (dropdownvalue == "" ||
                          dropdownvalue == null ||
                          password_textbox_controller.text == null ||
                          id_textbox_controller.text == null ||
                          docSnapshot == 0 ||
                          docSnapshot == null) {
                        print("some value is  null in driver login");
                      }

                      if (docSnapshot == null) {
                      } else if (docSnapshot.exists) {
                        Map<String, dynamic> data = await docSnapshot.data()!;
                        get_password_from_firebase = await data["password"];
                      }
                      if (get_password_from_firebase ==
                          password_textbox_controller.text) {
                        print("bhai hu aya");

                        Provider.of<Alldata>(context, listen: false)
                                .driver_selected_institute_at_driverlogin =
                            dropdownvalue;
                        Provider.of<Alldata>(context, listen: false)
                            .driver_name_at_driverlogin=id_textbox_controller.text;
                        Navigator.pushNamed(context, "driverwelcomescreen");
                      } else {
                        Fluttertoast.showToast(
                            msg: "Wrong Credentials",
                            backgroundColor: Colors.red[400]);
                      }
                    }
                  }),
                  child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.16,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child:
                              Text(email_or_phone ? "SEND OTP" : "SIGN IN")))),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("log in with "),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        email_or_phone = !email_or_phone;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 7),
                      height: 30,
                      child: Text(
                        email_or_phone ? " Email" : " Mobile number",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget id_textbox(id_textbox_controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      controller: id_textbox_controller,
      onChanged: ((value) {}),
      decoration: InputDecoration(
          hintText: "Enter Id",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          fillColor: Colors.white,
          filled: true),
    ),
  );
}

Widget password_textbox(password_textbox_controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      controller: password_textbox_controller,
      keyboardType: TextInputType.phone,
      onChanged: ((value) {}),
      decoration: InputDecoration(
          hintText: "Password",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          fillColor: Colors.white,
          filled: true),
    ),
  );
}
