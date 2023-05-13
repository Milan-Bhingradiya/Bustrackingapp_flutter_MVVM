import 'package:cloud_firestore/cloud_firestore.dart';

class Modelofdrivers {
  String? drivername;
  // String? driveremail;
  String? driverphonenumber;
  String? driver_doc_u_id;
  String? profile_img_link;
  double? lat;
  double? long;
  final documentSnapshot;

  Modelofdrivers(this.documentSnapshot) {
    lat = documentSnapshot["letitude"];
    long = documentSnapshot["longitude"];
    drivername = documentSnapshot["drivername"];
    driver_doc_u_id = documentSnapshot.id;
    // driveremail = QueryDocumentSnapshot["email"];
    driverphonenumber = documentSnapshot["driverphonenumber"];
    profile_img_link= documentSnapshot["profile_img_link"];
  }
}
