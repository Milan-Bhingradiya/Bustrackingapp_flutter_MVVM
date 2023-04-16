import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/adminhomescreen.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class School_auth_screen extends StatefulWidget {
  const School_auth_screen({super.key});

  @override
  State<School_auth_screen> createState() => _School_auth_screenState();
}

class _School_auth_screenState extends State<School_auth_screen> {
  dynamic schooladmin_loginscreen_viewmodel = null;

  TextEditingController passwordcontroller = TextEditingController();

  String dropdownvalue = "";

  milanop() async {
    schooladmin_loginscreen_viewmodel =
        await Provider.of<Schooladmin_loginscreen_viewmodel>(context,
            listen: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width / 25),
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "schooladmin",
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/images/selectscreen_school_logo.png"),
                        radius: 45,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 30,
                    ),
                    Text(
                      "SCHOOL ADMIN",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      child: DropdownButtonFormField2(
                        ////
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: size.height / 3,
                          width: size.width / 1.1777,
                          padding: null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          offset: const Offset(-9, 0),
                        ),

                        // this is from dropdown pac for style dropdownitems...
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),

                        isExpanded: true,

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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      height: size.height / 12,
                      width: double.infinity,
                    )),
                SizedBox(
                  height: size.height / 35,
                ),
                password_textbox(passwordcontroller),
                SizedBox(
                  height: size.height / 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (!(dropdownvalue == "" || dropdownvalue == null)) {
                      bool user_valid_or_not =
                          await schooladmin_loginscreen_viewmodel
                              .check_authenticity_of_user(
                                  dropdownvalue, passwordcontroller);

                      if (user_valid_or_not) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => adminhomescreen(),
                            ));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Wrong Credentials",
                            backgroundColor: Colors.red[400]);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 300,
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 25),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget password_textbox(passwordcontroller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      controller: passwordcontroller,
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
