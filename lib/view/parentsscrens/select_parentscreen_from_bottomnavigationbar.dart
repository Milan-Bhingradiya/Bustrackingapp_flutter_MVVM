import 'package:bustrackingapp/res/component/parent/bottomnavigationbar.dart';
import 'package:bustrackingapp/view/parentsscrens/chat/select_driver_for_chat.dart';
import 'package:bustrackingapp/view/parentsscrens/homescreen/parentwelcomescreen.dart';
import 'package:bustrackingapp/view/parentsscrens/profile/parentprofilescreen.dart';
import 'package:bustrackingapp/view/parentsscrens/trackingbus/track/screen/trackscreen.dart';
import 'package:bustrackingapp/view_model/parents/parent_bottomnavigationbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class select_parentscreen_from_bottomnavigationbar extends StatefulWidget {
  const select_parentscreen_from_bottomnavigationbar({super.key});

  @override
  State<select_parentscreen_from_bottomnavigationbar> createState() =>
      _select_parentscreen_from_bottomnavigationbarState();
}

class _select_parentscreen_from_bottomnavigationbarState
    extends State<select_parentscreen_from_bottomnavigationbar> {
  final List<Widget> _children = [
    parentwelcomescreen(),
    trackscreen(),
    parentprofilescreen(),
    select_driver_for_chat()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[
          Provider.of<Parent_bottomnavigationbar_viewmodel>(context,
                  listen: true)
              .selected_index_of_bottomnavigationbar],
      bottomNavigationBar: bottomnavigationbar_widget(),
    );
  }
}
