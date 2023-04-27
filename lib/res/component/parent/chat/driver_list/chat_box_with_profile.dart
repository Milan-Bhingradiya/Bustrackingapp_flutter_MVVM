import 'package:bustrackingapp/view_model/parents/parent_chattingscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class parent_chat_box_with_profile extends StatelessWidget {
  final title; //name
  final subtitile;
  final profileimglink;
  final u_id;
  const parent_chat_box_with_profile(
      {super.key,
      @required this.title,
      @required this.subtitile,
      @required this.profileimglink,
      @required this.u_id});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
          bottom: size.width / 35),
      child: GestureDetector(
        onTap: () {
          print("ah");

          print(u_id);
          final parent_chattingscreen_viewmodel =
              Provider.of<Parent_chattingscreen_viremodel>(context,
                  listen: false);
          parent_chattingscreen_viewmodel.drivername = this.title;
          parent_chattingscreen_viewmodel.profile_img_link =
              this.profileimglink;
          parent_chattingscreen_viewmodel.driver_doc_u_id = this.u_id;
          parent_chattingscreen_viewmodel.driver_name = this.title.toString();

          Navigator.pushNamed(context, "Chatting_screen");
        },
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
                backgroundColor: Colors.white,
                radius: size.height / 30,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                foregroundImage: NetworkImage(profileimglink),
              ),
              SizedBox(
                width: size.width / 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString(),
                    style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: size.height / 300,
                  ),
                  Text(
                    subtitile.toString(),
                    style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
