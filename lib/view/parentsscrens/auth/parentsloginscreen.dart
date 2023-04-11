import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bustrackingapp/model/parent/auth/parent_enum.dart';

TextEditingController id_textbox_conroller = TextEditingController();
TextEditingController password_textbox_conroller = TextEditingController();

class parentsloginscreen extends StatefulWidget {
  static late String phonenumber;
  static late String verificationid;

  @override
  State<parentsloginscreen> createState() => _parentsloginscreenState();
}

class _parentsloginscreenState extends State<parentsloginscreen> {
  dynamic parent_loginscreen_viewmodel = null;
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
    parent_loginscreen_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);
    Provider.of<Alldata>(context, listen: false)
        .fill_list_of_institute_dropdownitem();
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<Alldata>(context, listen: false)
    //     .fill_list_of_institute_dropdownitem();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "PARENTS",
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(
                      height: 30,
                    ),

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
                                icon:
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                                hint: Text("select institute"),
                                value:
                                    dropdownvalue == "" || dropdownvalue == null
                                        ? null
                                        : dropdownvalue,
                                items:
                                    Provider.of<Alldata>(context, listen: false)
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

                    if (email_or_phone) mobile_num_textbox(),
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
                              phoneNumber:
                                  '+91${parentsloginscreen.phonenumber}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                // Provider.of<Alldata>(context, listen: false)
                                //         .parent_login_verification_id =
                                verificationId;
                                Navigator.pushNamed(
                                    context, "parentloginotpscreen");
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );

                            // Navigator.pushNamed(context, "parentloginotpscreen");
                          } else {
                            print("this number is not exist");

                            //  Navigator.pushNamed(context, "parentwelcomescreen");
                          }

                          //TODO: logic of  auth with pass
                          if (email_or_phone == false) {
                            Enum user_valid_or_not =
                                await parent_loginscreen_viewmodel
                                    .check_authenticity_of_user(
                                        dropdownvalue.toString(),
                                        id_textbox_conroller.text,
                                        password_textbox_conroller.text);

                            if (user_valid_or_not ==
                                user_valid_or_invalid_or_emptyfiled_in_parent
                                    .Empty) {
                              print("empty");
                              Fluttertoast.showToast(
                                  msg: "Enter all field ",
                                  backgroundColor: Colors.red[400]);
                            } else if (user_valid_or_not ==
                                user_valid_or_invalid_or_emptyfiled_in_parent
                                    .False) {
                              print("false");
                              Fluttertoast.showToast(
                                  msg: "Wrong Credentials",
                                  backgroundColor: Colors.red[400]);
                            } else if (user_valid_or_not ==
                                user_valid_or_invalid_or_emptyfiled_in_parent
                                    .True) {
                              print("true");
                              Navigator.pushNamed(
                                  context, "parentwelcomescreen");
                            }
                          }

                          ////

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
                                child: Text(
                                    email_or_phone ? "SEND OTP" : "SIGN IN")))),
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
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
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
