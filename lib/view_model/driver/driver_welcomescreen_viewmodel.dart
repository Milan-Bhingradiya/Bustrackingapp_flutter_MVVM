import 'package:bustrackingapp/data/network_services/driver_services/driver_location_upload_service.dart';

import 'package:bustrackingapp/view_model/driver/driver_loginscreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Driver_welcomescreen_viewmodel extends ChangeNotifier {
  Driver_location_upload_service driver_location_upload_service =
      Driver_location_upload_service();
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

    driver_location_upload_service.get_livelocation_and_upload_to_db(
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
    driver_location_upload_service.get_livelocation_and_upload_to_db(
        institutename, drivername, false);
  }
}
