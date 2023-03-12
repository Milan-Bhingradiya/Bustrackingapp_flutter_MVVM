import 'package:cloud_firestore/cloud_firestore.dart';

// doc to obj ........
class model {
  late String drivername;
  late int driverphonenumber;
  late String password;
  late String lat;
  late String long;
  late String busnum;
   final QueryDocumentSnapshot;

  model(this.QueryDocumentSnapshot) {
    // here ass*hole int lat & long woking idk why so use string
    this.lat = QueryDocumentSnapshot["letitude"].toString();
    this.long = QueryDocumentSnapshot["longitude"].toString();
    drivername = QueryDocumentSnapshot["drivername"];
    password = QueryDocumentSnapshot["password"];
   // busnum= QueryDocumentSnapshot["busnum"];
  }

  functionofmodel() {
    print(QueryDocumentSnapshot);
  }
}
