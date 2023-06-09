import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view/admin/admin.dart';

import 'package:bustrackingapp/view/school_admin/adminhomescreen.dart';
import 'package:bustrackingapp/view_model/admin/admin_viewmodel.dart';
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
  dynamic admin_viewmodel = null;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admin_viewmodel = Provider.of<Admin_viewmodel>(context, listen: false);
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width / 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: size.height / 4.5,
                      width: size.width / 2.5,
                      // decoration: BoxDecoration(
                      //     color: Colors.amber,
                      //     borderRadius: BorderRadius.circular(8)),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset("assets/images/adminlogo.png")),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    textbox(admin_viewmodel, "id"),
                    SizedBox(
                      height: size.height / 35,
                    ),
                    textbox(admin_viewmodel, "Password"),
                    SizedBox(
                      height: size.height / 25,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        bool valid =
                            await admin_viewmodel.check_admin_authenticity();

                        if (valid) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => admin(),
                              ));
                        } else {
                          setState(() {
                            loading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "wrong credential",
                              backgroundColor: Colors.red);
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
            Visibility(
              visible: loading,
              child: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            )
          ],
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
    child: TextFormField(
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
              borderSide: BorderSide(color: Colors.grey.shade800)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          fillColor: Colors.white,
          filled: true),
    ),
  );
}
