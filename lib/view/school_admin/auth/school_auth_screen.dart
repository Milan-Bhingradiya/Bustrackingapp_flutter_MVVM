import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/school_admin/adminhomescreen.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "SCHOOL ADMIN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
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
                  height: 30,
                ),
                password_textbox(passwordcontroller),
                SizedBox(
                  height: 60,
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
