import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class select_driver_for_chat extends StatefulWidget {
  const select_driver_for_chat({super.key});

  @override
  State<select_driver_for_chat> createState() => _select_driver_for_chatState();
}

class _select_driver_for_chatState extends State<select_driver_for_chat> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 12,
            ),
            serchbox_textfield(size),
            SizedBox(
              height: size.height / 20,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(children: [
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                  driver_chat_box(size),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget serchbox_textfield(size) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width / 20),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search conversation",
        hintStyle: GoogleFonts.robotoMono(
          textStyle: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Colors.black38,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: IconButton(
          icon: Icon(
            CupertinoIcons.search,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
      ),
    ),
  );
}

Widget driver_chat_box(size) {
  return Padding(
    padding: EdgeInsets.only(
        left: size.width / 25, right: size.width / 25, bottom: size.width / 35),
    child: Container(
      height: size.height / 11,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: size.width / 30,
          ),
          CircleAvatar(
            radius: size.height / 30,
          ),
          SizedBox(
            width: size.width / 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MIlan Bhinradiya",
                style: GoogleFonts.josefinSans(
                    textStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: size.height / 300,
              ),
              Text(
                " i am bus driver",
                style: GoogleFonts.josefinSans(
                    textStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Spacer(),
          Text("12:00"),
          SizedBox(
            width: size.width / 30,
          ),
        ],
      ),
    ),
  );
}
