import 'package:bustrackingapp/res/component/parent/chat/driver_list/chat_box_with_profile.dart';
import 'package:bustrackingapp/view_model/parents/parent_selectdriver_for_chat_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class select_driver_for_chat extends StatefulWidget {
  const select_driver_for_chat({super.key});

  @override
  State<select_driver_for_chat> createState() => _select_driver_for_chatState();
}

class _select_driver_for_chatState extends State<select_driver_for_chat> {
  dynamic parent_selectdriver_for_chat_screen_viewmodel = null;

  bool searching = false;

  void milanop(context) async {
    await parent_selectdriver_for_chat_screen_viewmodel
        .make_all_drivers_chatbox(context);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    parent_selectdriver_for_chat_screen_viewmodel =
        Provider.of<Parent_selectdriver_for_chat_screen_viewmodel>(context,
            listen: false);

    milanop(context);
  }

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
            serchbox_textfield(
                size, parent_selectdriver_for_chat_screen_viewmodel),
            SizedBox(
              height: size.height / 20,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                    children: (parent_selectdriver_for_chat_screen_viewmodel
                                .list_of_drivers_chatbox_widget.length ==
                            0)
                        ? [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ]

                        // why again write provider.of ? beacuase listen is true not in upper mentioned
                        : (Provider.of<Parent_selectdriver_for_chat_screen_viewmodel>(
                                        context,
                                        listen: true)
                                    .searchlist
                                    .length ==
                                0)
                            ? parent_selectdriver_for_chat_screen_viewmodel
                                .list_of_drivers_chatbox_widget
                            : parent_selectdriver_for_chat_screen_viewmodel
                                .searchlist),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget serchbox_textfield(size, parent_selectdriver_for_chat_screen_viewmodel) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width / 20),
    child: TextField(
      onChanged: (value) {
        parent_selectdriver_for_chat_screen_viewmodel.searchlist.clear();

        for (var element in parent_selectdriver_for_chat_screen_viewmodel
            .list_of_drivers_chatbox_widget) {
          print(element.title);
          /// if exist title's any alphbet match with enterd alphabet then add and show...
          if (element.title.toLowerCase().contains(value.toLowerCase())) {
            parent_selectdriver_for_chat_screen_viewmodel
                .set_searchlist(element);
          }
        }
      },
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
