import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_driver_viewmodel.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class adddriverscreen extends StatefulWidget {
  const adddriverscreen({super.key});

  @override
  State<adddriverscreen> createState() => _adddriverscreenState();
}

class _adddriverscreenState extends State<adddriverscreen> {
  dynamic schooladmin_driver_viewmodel = null;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<DropdownMenuItem> listof_bus_dropdown = [];
  String? dropdownvalue = "";

  milanop() {
    schooladmin_driver_viewmodel =
        Provider.of<Schooladmin_driver_viewmodel>(context, listen: false);

    schooladmin_driver_viewmodel
        .read_data_and_fill_list_of_bus_dropdown(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    milanop();
  }

  @override
  Widget build(BuildContext context) {
    print("build is called");
    print(listof_bus_dropdown.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add driver"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "ADD driver info",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_driver_name_textformfield(
                              schooladmin_driver_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_driver_phonenumber_textformfield(
                              schooladmin_driver_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_driver_password_textformfield(
                              schooladmin_driver_viewmodel)),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        color: Colors.amber,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: enter_driver_confirmpassword_textformfield(
                              schooladmin_driver_viewmodel)),
                      SizedBox(
                        height: 35,
                      ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Select Bus"),
                          DropdownButton(
                              // aya value 9 slect thay ane list ma 2 var 9 hoy etle error ave, milan  will in future...
                              value:
                                  dropdownvalue == "" || dropdownvalue == null
                                      ? null
                                      : dropdownvalue,
                              hint: Text("Select bus "),
                              items: Provider.of<Schooladmin_driver_viewmodel>(
                                      context)
                                  .get_listof_bus_dropdown(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownvalue = value;
                                  schooladmin_driver_viewmodel.selectedbusnum =
                                      dropdownvalue;
                                });
                              })
                        ],
                      ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            print("succesful");
                            try {
                              bool updated_or_fail =
                                  await schooladmin_driver_viewmodel
                                      .add_driver(context);

                              if (updated_or_fail) {
                                Fluttertoast.showToast(msg: "New Driver added");
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa $e");
                            } on Exception {
                              print("zzzzzzzzzzzzzzzzzzzzzz");
                            }
                            ;
                          } else {
                            print("unsuccesful");
                            Fluttertoast.showToast(msg: "unsuccesful to add");
                          }

                          // FirebaseFirestore.instance.collection('drivers').doc('')
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 100,
                          color: Colors.deepPurple,
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget enter_driver_name_textformfield(schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Enter Driver name",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "enter value";
      } else {
        return null;
      }
    },
    onChanged: (value) {
      schooladmin_driver_viewmodel.drivername = value;
    },
  );
}

Widget enter_driver_phonenumber_textformfield(schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Enter Driver phone number",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "enter value";
      } else {
        return null;
      }
    },
    onChanged: (value) {
      schooladmin_driver_viewmodel.driverphonenumber = value;
    },
  );
}

Widget enter_driver_password_textformfield(schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Enter password",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "enter value";
      } else {
        return null;
      }
    },
    onChanged: (value) {
      schooladmin_driver_viewmodel.driverpassword = value;
    },
  );
}

Widget enter_driver_confirmpassword_textformfield(
    schooladmin_driver_viewmodel) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Enter confirm password",
      counterText: '',
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "enter value";
      }

      if (schooladmin_driver_viewmodel.driverpassword !=
          schooladmin_driver_viewmodel.confirmdriverpassword) {
        return "password mismatch";
      }
      if (schooladmin_driver_viewmodel.driverpassword ==
          schooladmin_driver_viewmodel.confirmdriverpassword) {}
    },
    onChanged: ((value) {
      schooladmin_driver_viewmodel.confirmdriverpassword = value;
    }),
  );
}
