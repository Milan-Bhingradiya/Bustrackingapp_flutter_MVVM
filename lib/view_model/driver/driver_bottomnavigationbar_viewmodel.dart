//driver_select_screen_from_bottomnavigationbar_viewmodel.dart
import 'package:flutter/material.dart';

class Driver_bottomnavigationbar_viewmodel extends ChangeNotifier {
var selected_index_of_bottomnavigationbar = 0;

  void ontap_of_bottom_navigationbar(int value) {
    selected_index_of_bottomnavigationbar = value;
    notifyListeners();
  }
  
}
