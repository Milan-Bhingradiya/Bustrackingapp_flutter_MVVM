import 'package:bustrackingapp/view_model/admin/admin_addinstitute_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class add_school extends StatefulWidget {
  const add_school({super.key});

  @override
  State<add_school> createState() => _add_schoolState();
}

class _add_schoolState extends State<add_school> {
  dynamic admin_addinstitute_viewmodel = null;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admin_addinstitute_viewmodel =
        Provider.of<Admin_addinstitute_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("lets add school")),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter school name";
                    }
                    if (value == "") {
                      return "Enter school name";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'School name',
                    counterText: '',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    admin_addinstitute_viewmodel.institutename = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password name";
                    }
                    if (value == "") {
                      return "Enter password name";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'password',
                    counterText: '',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    admin_addinstitute_viewmodel.institutepassword = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter confirm password";
                    }
                    if (value == "") {
                      return "Enter confirm password";
                    }

                    if (admin_addinstitute_viewmodel.institutepassword !=
                        value) {
                      return "password not match";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'confirm password',
                    counterText: '',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    admin_addinstitute_viewmodel.instituteconfirmpassword =
                        value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(11),
                child: GestureDetector(
                    onTap: () async {
                      if (key.currentState!.validate()) {
                        bool done =
                            await admin_addinstitute_viewmodel.add_institute();

                        if (done) {
                          Fluttertoast.showToast(msg: "new school is added");
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: "try again new school is not added");
                        }
                      }
                    },
                    child: Container(
                      child: Center(
                        child: Text("Submit"),
                      ),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
