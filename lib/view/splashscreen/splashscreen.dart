import 'package:bustrackingapp/view/selectwhoyouarescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => selectwhoyouarescreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            //     decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage("assets/images/splash_screen_image.png"),
            //       fit: BoxFit.fitHeight),
            // )

            color: Colors.deepPurple[800],
            child: Center(
              child: Text(
                "We Track",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
