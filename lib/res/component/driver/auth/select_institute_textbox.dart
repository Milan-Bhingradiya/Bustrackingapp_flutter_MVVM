import 'package:bustrackingapp/providers/provider.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class select_institute_textbox extends StatefulWidget {
  final listofdropdown;
   var dropdownvalue = "";

   select_institute_textbox({
    super.key,
    this.listofdropdown,
  });

  @override
  State<select_institute_textbox> createState() =>
      _select_institute_textboxState();
}

class _select_institute_textboxState extends State<select_institute_textbox> {
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              value: widget.dropdownvalue == "" ||widget. dropdownvalue == null
                  ? null
                  : widget.dropdownvalue,
              items: Provider.of<Alldata>(context, listen: false)
                  .list_of_institute_dropdownitem,
              onChanged: (value) {
                setState(() {
                  widget.dropdownvalue = value;
                  print(widget.dropdownvalue);
                });
              },
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          height: 55,
          width: double.infinity,
        ));
  }
}
