
import 'package:bustrackingapp/view_model/parents/parent_trackbusscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bus_and_num_widget extends StatefulWidget {
  bus_and_num_widget({super.key, required this.busnum, required this.img_path});

  final busnum;
  final img_path;

  @override
  State<bus_and_num_widget> createState() => _bus_and_num_widgetState();
}

class _bus_and_num_widgetState extends State<bus_and_num_widget> {

dynamic parent_trackbusscreen_viewmodel=null;
  bool tick = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     parent_trackbusscreen_viewmodel =
        Provider.of<Parent_trackbusscreen_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          print("ohhhhhhhhhhhhhhhhhhhhhhh");
          setState(() {
            tick = !tick;
            if (tick == false) {
            parent_trackbusscreen_viewmodel
                  .list_of_selected_bus
                  .removeWhere(
                (element) {

                  // aya check thay badha element hare jaya true thay e delete thay
                  return element == this.widget.busnum;
                },
              );
              // print(
              //     "new datattatat ${Provider.of<Alldata>(context, listen: false).list_of_selected_bus} ");
            } else if (tick == true) {
                  parent_trackbusscreen_viewmodel
                  .list_of_selected_bus
                  .add(this.widget.busnum);

              // print(
              //     "new datattatat ${Provider.of<Alldata>(context, listen: false).list_of_selected_bus} ");
            }
          });
        },
        child: Container(
          height: 100,
          width: 65,
          child: Column(
            children: [
              Stack(
                children: [
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(40),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage(widget.img_path),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: tick,
                    child: Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage:
                              AssetImage("assets/images/true_logo.png"),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                height: 15,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Text(widget.busnum.toString()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
