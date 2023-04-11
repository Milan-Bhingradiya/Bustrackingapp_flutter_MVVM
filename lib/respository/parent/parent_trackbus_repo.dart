import 'package:bustrackingapp/data/network_services/parent_services/parent_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Parent_trackbus_repo {
  Parent_firestore_service parent_firestore_service =
      Parent_firestore_service();

  Future<QuerySnapshot> get_driver_collection_querysnapshot(
      institutename) async {
    return await parent_firestore_service
        .get_driver_collection_querysnapshot(institutename);
  }
}
