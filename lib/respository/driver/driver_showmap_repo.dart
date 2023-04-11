import 'package:bustrackingapp/data/network_services/driver_services/driver_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Driver_showmap_repo {
  Driver_firestore_service driver_firestore_service =
      Driver_firestore_service();

//this function is use less i can dirctly service function but someone say do this for abstration so thatswhy....
  Future<QuerySnapshot> get_all_parent_of_given_institute(institutename) async {
    final QuerySnapshot result = await driver_firestore_service
        .get_parent_documentist_of_given_institutename(institutename);
    return result;
  }
}
