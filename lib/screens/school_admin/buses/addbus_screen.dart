import 'package:bustrackingapp/providers/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class addbusscreen extends StatefulWidget {
  const addbusscreen({super.key});

  @override
  State<addbusscreen> createState() => _addbusscreenState();
}

class _addbusscreenState extends State<addbusscreen> {
  TextEditingController controller = TextEditingController();

  late String institute_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    institute_name = Provider.of<Alldata>(context,listen: false)
      .selected_schholname_from_schhol_auth;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fill new bus detail")),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,

              // enabled: textfield_enable,

              decoration: InputDecoration(
                labelText: 'Bus number',

                // errorText: errortext_drivernamefield,

                //  errorText: "name is not valid",

                counterText: '',

                border: const OutlineInputBorder(),

                prefixIcon: const Icon(Icons.person),
              ),

              onChanged: (value) {
                setState(() {
                  // new_drivername = value;

                  // print(new_drivername);

                  // print(errortext_drivernamefield);

                  // if (new_drivername.isEmpty) {

                  //   errortext_drivernamefield = 'Name is required';

                  // } else if (new_drivername.length < 3) {

                  //   errortext_drivernamefield = 'Name must be at least 3 characters';

                  // } else {

                  //   errortext_drivernamefield = null;

                  // }
                });

                setState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(11),
            child: GestureDetector(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('main')
                      .doc("main_document")
                      .collection("institute_list")
                      .doc(institute_name)
                      .collection("buses")
                      .doc(controller.text)
                      .set({"busnum": "${controller.text}"}).then((value) {
                    Fluttertoast.showToast(msg: "new bus ia added");
                  });
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
    );
  }
}
