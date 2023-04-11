import 'package:bustrackingapp/data/network_services/driver_services/driver_location_upload_service.dart';

class Driver_welcome_repo {
  Driver_location_upload_service driver_location_upload_service =
      Driver_location_upload_service();

  void upload_driverlive_location(
      institutename, drivername, bool on_or_off) async {
    driver_location_upload_service.get_livelocation_and_upload_to_db(
        institutename, drivername, on_or_off);
  }
}
