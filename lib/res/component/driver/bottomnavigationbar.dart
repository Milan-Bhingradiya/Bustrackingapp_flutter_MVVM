import 'package:bustrackingapp/view_model/driver/driver_bottomnavigationbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bottomnavigationbar_widget extends StatelessWidget {
  List<BottomNavigationBarItem> list_of_BottomNavigationBarItem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.directions_bus), label: "Live buses"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        Provider.of<Driver_bottomnavigationbar_viewmodel>(context,
                listen: false)
            .ontap_of_bottom_navigationbar(value);
        print("clicked           $value");
      },
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      //  backgroundColor: Colors.black,
      items: list_of_BottomNavigationBarItem,
      type: BottomNavigationBarType.fixed,
      currentIndex:
          Provider.of<Driver_bottomnavigationbar_viewmodel>(context,
                  listen: false)
              .selected_index_of_bottomnavigationbar,
      // selectedItemColor: Colors.black,
      elevation: 5,
    );
  }
}
