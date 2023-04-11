import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/res/component/driver/auth/custom_textbox.dart';
import 'package:bustrackingapp/res/component/driver/auth/select_institute_textbox.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bustrackingapp/model/driver/auth/driver_enum.dart';

class driverloginscreen extends StatefulWidget {
  static late String phonenumber;
  static late String verificationid;

  @override
  State<driverloginscreen> createState() => _driverloginscreenState();
}

class _driverloginscreenState extends State<driverloginscreen> {
  //new
  late final driver_login_viewmodel;

  TextEditingController mobile_number_textbox_controller =
      TextEditingController();
  TextEditingController id_textbox_controller = TextEditingController();
  TextEditingController password_textbox_controller = TextEditingController();
  late String password;

  String errormsg = "";

  String dropdownvalue = "";

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Alldata>(context, listen: false)
        .fill_list_of_institute_dropdownitem();

    driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<Alldata>(context, listen: false)
        .list_of_institute_dropdownitem
        .length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "DRIVER",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 30,
              ),
              if (email_or_phone)
                custom_textbox(
                  controller: mobile_number_textbox_controller,
                  hinttext: "Enter mobile Number",
                ),
              if (!email_or_phone)
                // select_institute_textbox(
                //   listofdropdown: Provider.of<Alldata>(context, listen: false)
                //       .list_of_institute_dropdownitem,
                // ),
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
                height: 8,
              ),
              if (!email_or_phone)
                custom_textbox(
                  controller: id_textbox_controller,
                  hinttext: "Enter driver name",
                ),
              SizedBox(
                height: 8,
              ),
              if (!email_or_phone)
                custom_textbox(
                  controller: password_textbox_controller,
                  hinttext: "Enter password",
                ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: (() async {
                    print("dropdownvalue $dropdownvalue");
                    print(password_textbox_controller.text);

                    //     bool checknumexistornot =
                    //     await doesPhonenumberAlreadyExist(phonenumber.toString());

//TODO:       aa function ne view model ma mukvu

// login using mobbile number/////////
                    if (email_or_phone) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '+91${mobile_number_textbox_controller.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          // Provider.of<Alldata>(context, listen: false)
                          //     .parent_login_verification_id = verificationId;
                          Navigator.pushNamed(context, "parentloginotpscreen");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                      Navigator.pushNamed(context, "parentloginotpscreen");
                    } else {}
                    // if (user != null) {
                    //   Navigator.pushNamed(context, "adminhomescreen");
                    // }

//TODO: logic of  auth with pass

                    if (email_or_phone == false) {
                      Enum user_valid_or_not = await driver_login_viewmodel
                          .check_authenticity_of_user(
                              dropdownvalue.toString(),
                              id_textbox_controller.text,
                              password_textbox_controller.text);

                      if (user_valid_or_not ==
                          user_valid_or_invalid_or_emptyfiled.Empty) {
                        print("empty");
                        Fluttertoast.showToast(
                            msg: "Enter all field ",
                            backgroundColor: Colors.red[400]);
                      } else if (user_valid_or_not ==
                          user_valid_or_invalid_or_emptyfiled.False) {
                        print("false");
                        Fluttertoast.showToast(
                            msg: "Wrong Credentials",
                            backgroundColor: Colors.red[400]);
                      } else if (user_valid_or_not ==
                          user_valid_or_invalid_or_emptyfiled.True) {
                        print("true");
                        Navigator.pushNamed(context, "driverwelcomescreen");
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
