import 'package:bustrackingapp/view_model/parents/parent_chattingscreen_viewmodel.dart';
import 'package:bustrackingapp/view_model/parents/parent_loginscreen_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Chatting_screen extends StatefulWidget {
  const Chatting_screen({super.key});

  @override
  State<Chatting_screen> createState() => _Chatting_screenState();
}

class _Chatting_screenState extends State<Chatting_screen> {
  TextEditingController chat_textfield_controller = TextEditingController();
  dynamic parent_chattingscreen_viewmodel = null;
  dynamic parent_loginscreen_viewmodel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    parent_chattingscreen_viewmodel =
        Provider.of<Parent_chattingscreen_viremodel>(context, listen: false);
    parent_loginscreen_viewmodel =
        Provider.of<Parent_loginscreen_viewmodel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return (parent_chattingscreen_viewmodel == null)
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                ),
              ),
              title: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(
                          parent_chattingscreen_viewmodel.profile_img_link,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        parent_chattingscreen_viewmodel.drivername,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Active Now",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  splashColor: Colors.blue.withOpacity(0.4),
                  icon: Icon(
                    CupertinoIcons.phone,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashColor: Colors.blue.withOpacity(0.4),
                  icon: Icon(
                    CupertinoIcons.video_camera,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashColor: Colors.blue.withOpacity(0.4),
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                    flex: 6,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("main")
                          .doc("main_document")
                          .collection("institute_list")
                          .doc(parent_loginscreen_viewmodel.institute_doc_u_id
                              .toString())
                          .collection("parents")
                          .doc(parent_loginscreen_viewmodel.parent_doc_u_id
                              .toString())
                          .collection("chat")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //here "final chat document" is list... we use first ...
                          final chat_document = snapshot.data!.docs.where(
                              (element) =>
                                  element.id ==
                                  "with_d_${parent_chattingscreen_viewmodel.driver_doc_u_id}");

                          List<msgbubble> listofmsg = [];
                          List list_of_sended_messages = [];
                          List list_of_received_messages = [];

                          List xx = [];
                          List yy = [];

                          try {
                            if (chat_document.isEmpty) {
                              print(
                                  "chat_document is empty in parent chatting screen");
                            }
                            if (chat_document.isNotEmpty) {
                              bool xx_bool = chat_document.first
                                  .data()
                                  .containsKey("sended_messages");
                              if (xx_bool) {
                                xx = chat_document.first.get("sended_messages");
                              }

                              bool yy_bool = chat_document.first
                                  .data()
                                  .containsKey("received_messages");
                              if (yy_bool) {
                                yy = chat_document.first
                                    .get("received_messages");
                              }
                            }
                          } catch (e) {
                            print(e);
                            print(
                                "aa aya driver chatting screen ma problem...");
                          }

                          list_of_sended_messages =
                              list_of_sended_messages + xx;

                          list_of_received_messages =
                              list_of_received_messages + yy;

                          List allmsg = list_of_sended_messages +
                              list_of_received_messages;

                          List sort_allmsg = allmsg
                            ..sort((a, b) =>
                                a["milisecond"].compareTo(b["milisecond"]));
                          for (var i = 0; i < sort_allmsg.length; i++) {
                            final msg_bubble = msgbubble(
                                "${sort_allmsg[i]["msg"]}",
                                // chat_document.first.get("sended_messages")[i]
                                //     ["msg"],
                                "op",
                                ("${sort_allmsg[i]["send_or_recive"]}" ==
                                        "send")
                                    ? true
                                    : false,
                                "time",
                                123);

                            listofmsg.add(msg_bubble);
                          }

                          return ListView(
                            children: listofmsg,
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000",
                              ),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          // child: Image.network(
                          //   "https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000",
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: chat_textfield_controller,
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            parent_chattingscreen_viewmodel.upload_msg_to_db(
                                context, chat_textfield_controller);

                            print("after toych");
                          },
                          child: Icon(
                            Icons.send,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class msgbubble extends StatelessWidget {
  String msgtext;
  String msgusername;
  String time;
  int timeindex;
  bool isme;
  msgbubble(
      this.msgtext, this.msgusername, this.isme, this.time, this.timeindex);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment:
              isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(msgusername),
            Material(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: isme ? Radius.circular(7) : Radius.circular(0),
                  topEnd: isme ? Radius.circular(0) : Radius.circular(7),
                  bottomStart: Radius.circular(7),
                  bottomEnd: Radius.circular(7)),
              elevation: 14,
              color: isme ? Colors.amber[300] : Colors.blue[300],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                child: Text(
                  " $msgtext",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Text(time),
          ]),
    );
  }
}
