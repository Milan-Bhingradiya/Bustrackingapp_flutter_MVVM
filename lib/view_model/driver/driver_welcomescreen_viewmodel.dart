import 'package:bustrackingapp/respository/driver/driver_welcome_repo.dart';
import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Driver_welcomescreen_viewmodel extends ChangeNotifier {
  final Driver_welcome_repo driver_welcome_repo = Driver_welcome_repo();
  late String institutename;
  late String drivername;

  void upload_live_location(context) async {
    final driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);

    institutename = await driver_login_viewmodel
        .driver_selected_institute_at_driverlogin
        .toString();
    drivername =
        await driver_login_viewmodel.driver_name_at_driverlogin.toString();

    driver_welcome_repo.upload_driverlive_location(
        institutename, drivername, true);
  }

  void stop_livelocation(context) async {
    //nakamu
    final driver_login_viewmodel =
        Provider.of<Driver_loginscreen_viewmodel>(context, listen: false);
    institutename = await driver_login_viewmodel
        .driver_selected_institute_at_driverlogin
        .toString();
    drivername =
        await driver_login_viewmodel.driver_name_at_driverlogin.toString();
// nakamu end..
    driver_welcome_repo.upload_driverlive_location(
        institutename, drivername, false);
  }
}
