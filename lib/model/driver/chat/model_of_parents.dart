import 'package:cloud_firestore/cloud_firestore.dart';

class Modelofparents {
  String? parentname;
  String? parent_chilname;
  String? parentphonenumber;
  String? parent_doc_u_id;
  // double? lat;
  // double? long;
    String? profile_img_link;
  final documentSnapshot;

  Modelofparents(this.documentSnapshot) {
    // lat = documentSnapshot["letitude"];
    // long = documentSnapshot["longitude"];
    parentname = documentSnapshot["parentname"];
    parent_doc_u_id = documentSnapshot.id;
    parent_chilname = documentSnapshot["parentchildname"];
    parentphonenumber = documentSnapshot["parentphonenumber"];
     profile_img_link= documentSnapshot["profile_img_link"];
  }
}
