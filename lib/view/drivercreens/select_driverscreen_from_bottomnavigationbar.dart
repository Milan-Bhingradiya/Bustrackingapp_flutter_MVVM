import 'package:bustrackingapp/res/component/driver/bottomnavigationbar.dart';
import 'package:bustrackingapp/view/drivercreens/home/driverwelcomescreen.dart';
import 'package:bustrackingapp/view/drivercreens/profile/driverprofilescreen.dart';
import 'package:bustrackingapp/view/drivercreens/show_map/map_for_driver.dart';
import 'package:bustrackingapp/view_model/driver/driver_bottomnavigationbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class select_driverscreen_from_bottomnavigationbar extends StatefulWidget {
  const select_driverscreen_from_bottomnavigationbar({super.key});

  @override
  State<select_driverscreen_from_bottomnavigationbar> createState() =>
      _select_driverscreen_from_bottomnavigationbarState();
}

class _select_driverscreen_from_bottomnavigationbarState
    extends State<select_driverscreen_from_bottomnavigationbar> {
  final List<Widget> _children = [
    driverwelcomescreen(),
    mapfordriver(),
    driverprofilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[Provider.of<Driver_bottomnavigationbar_viewmodel>(context,
              listen: true)
          .selected_index_of_bottomnavigationbar],
      bottomNavigationBar: bottomnavigationbar_widget(),
    );
  }
}
