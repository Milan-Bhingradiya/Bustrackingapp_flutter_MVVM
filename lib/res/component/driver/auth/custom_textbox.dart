import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class custom_textbox extends StatelessWidget {
  final controller;
  final hinttext;
  const custom_textbox(
      {super.key, @required this.controller, @required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        onChanged: ((value) {}),
        decoration: InputDecoration(
            hintText: hinttext.toString(),
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
}
