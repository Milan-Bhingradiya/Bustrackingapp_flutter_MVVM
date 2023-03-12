import 'package:bustrackingapp/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

TextEditingController id_textbox_conroller = TextEditingController();
TextEditingController password_textbox_conroller = TextEditingController();

class parentsloginscreen extends StatefulWidget {
  static late String phonenumber;
  static late String verificationid;

  @override
  State<parentsloginscreen> createState() => _parentsloginscreenState();
}

class _parentsloginscreenState extends State<parentsloginscreen> {
//

  String dropdownvalue = "";

  ///
  late String password;

  String errormsg = "";

  bool email_or_phone = false;

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

    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<Alldata>(context, listen: false)
    //     .fill_list_of_institute_dropdownitem();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "PARENTS",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 60,
              ),
              if (email_or_phone) mobile_num_textbox(),
              ////////////////////////
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
              //////////////////
              if (!email_or_phone) id_textbox(),
              SizedBox(
                height: 5,
              ),
              if (!email_or_phone) password_textbox(),

              SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: (() async {
                    // bool checknumexistornot =
                    //     await doesPhonenumberAlreadyExist(phonenumber.toString());

                    //TODO: if phoene is slected floowinnd code will execute
                    if (false) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91${parentsloginscreen.phonenumber}',
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

                      // Navigator.pushNamed(context, "parentloginotpscreen");
                    } else {
                      print("this number is not exist");

                      //  Navigator.pushNamed(context, "parentwelcomescreen");
                    }

//TODO: logic of  auth with pass

                    var get_password_from_firebase;
                    var docSnapshot;
                    if (email_or_phone == false) {
                      if (dropdownvalue == "" ||
                          dropdownvalue == null ||
                          id_textbox_conroller.text == null ||
                          id_textbox_conroller.text == "") {
                      } else {
                        print("parent login getting password query fired");
                        docSnapshot = await FirebaseFirestore.instance
                            .collection("main")
                            .doc("main_document")
                            .collection("institute_list")
                            .doc("$dropdownvalue")
                            .collection("parents")
                            .doc(id_textbox_conroller.text.toString())
                            .get();
                      }

                      if (dropdownvalue == "" ||
                          dropdownvalue == null ||
                          id_textbox_conroller.text == null ||
                          docSnapshot == 0 ||
                          docSnapshot == null ||
                          docSnapshot == 0) {
                        print("some value is  null in parent login");
                      }

                      if (docSnapshot == null) {
                      } else if (docSnapshot.exists) {
                        Map<String, dynamic> data = await docSnapshot.data()!;
                        get_password_from_firebase = await data["password"];
                      }
                      if (get_password_from_firebase ==
                          password_textbox_conroller.text) {
                        print("bhai hu aya");

                        Provider.of<Alldata>(context, listen: false)
                                .parent_selected_institute_at_login_at_parentlogin =
                            dropdownvalue;

                             Provider.of<Alldata>(context, listen: false)
                                .parent_id_login_at_parentlogin =
                            id_textbox_conroller.text;
                        Navigator.pushNamed(context, "parentwelcomescreen");
                      } else {
                        Fluttertoast.showToast(
                            msg: "Wrong Credentials",
                            backgroundColor: Colors.red[400]);
                      }
                    }
                    // if (user != null) {
                    //   Navigator.pushNamed(context, "adminhomescreen");
                    // }
                  }),
                  child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.16,
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
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

Widget password_textbox() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      controller: password_textbox_conroller,
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

@override
Widget id_textbox() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      controller: id_textbox_conroller,
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

Widget mobile_num_textbox() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      keyboardType: TextInputType.phone,
      onChanged: ((value) {
        parentsloginscreen.phonenumber = value;
      }),
      decoration: InputDecoration(
          hintText: "Enter Mobie Number",
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
