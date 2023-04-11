import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/admin/admin.dart';

import 'package:bustrackingapp/view/school_admin/adminhomescreen.dart';
import 'package:bustrackingapp/view_model/admin/admin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class admin_login extends StatefulWidget {
  const admin_login({super.key});

  @override
  State<admin_login> createState() => _admin_login();
}

class _admin_login extends State<admin_login> {
  dynamic admin_loginscreen_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admin_loginscreen_viewmodel =
        Provider.of<Admin_loginscreen_viewmodel>(context, listen: false);
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
                  height: 30,
                ),
                Container(
                  height: 150,
                  width: 150,
                  // decoration: BoxDecoration(
                  //     color: Colors.amber,
                  //     borderRadius: BorderRadius.circular(8)),
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset("assets/images/adminlogo.png")),
                ),
                SizedBox(
                  height: 20,
                ),
                textbox(admin_loginscreen_viewmodel, "id"),
                SizedBox(
                  height: 30,
                ),
                textbox(admin_loginscreen_viewmodel, "Password"),
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () async {
                    bool valid = await admin_loginscreen_viewmodel
                        .check_admin_authenticity();

                    if (valid) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => admin(),
                          ));
                    } else {
                      Fluttertoast.showToast(
                          msg: "wrong credential", backgroundColor: Colors.red);
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

Widget textbox(
  admin_loginscreen_viewmodel,
  hinttext,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      keyboardType: TextInputType.name,
      onChanged: ((value) {
        print(hinttext);
        if (hinttext == "id") {
          print("nnnnnnn");
          admin_loginscreen_viewmodel.id = value;
        } else if (hinttext == "Password") {
          print("mmmmmmmmmm");
          admin_loginscreen_viewmodel.password = value;
        }
      }),
      decoration: InputDecoration(
          hintText: hinttext,
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
