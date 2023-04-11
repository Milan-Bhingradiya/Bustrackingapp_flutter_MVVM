import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/schooladmin/schooladmin_bus_viewmodel.dart';
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
  dynamic schooladmin_bus_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schooladmin_bus_viewmodel =
        Provider.of<Schooladmin_bus_viewmodel>(context, listen: false);
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
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Bus number',
                counterText: '',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (value) {
                schooladmin_bus_viewmodel.busnum = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(11),
            child: GestureDetector(
                onTap: () async {
                  bool updated_or_failed =
                      await schooladmin_bus_viewmodel.add_bus(context);
                  if (updated_or_failed) {
                    Fluttertoast.showToast(
                        msg:
                            "new bus ${schooladmin_bus_viewmodel.busnum} number ia added");
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: "fail to add new bus try again");
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
    );
  }
}
