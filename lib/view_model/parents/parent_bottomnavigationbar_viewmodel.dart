import 'package:flutter/material.dart';

class Parent_bottomnavigationbar_viewmodel extends ChangeNotifier {
  var selected_index_of_bottomnavigationbar = 0;

  void ontap_of_bottom_navigationbar(int value) {
    selected_index_of_bottomnavigationbar = value;
    notifyListeners();
  }
}
