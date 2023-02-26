

class modelofparents {
  late String parentname;
    late String parentchildname;
  late int parentphonenumber;
  late String password;
  late String lat;
  late String long;
  late final QueryDocumentSnapshot;



  modelofparents(this.QueryDocumentSnapshot) {
    // here ass*hole int lat & long woking idk why so use string 
     this.lat = QueryDocumentSnapshot["letitude"].toString();
   this.long = QueryDocumentSnapshot["longitude"].toString();
    parentname = QueryDocumentSnapshot["parentname"];
parentchildname=QueryDocumentSnapshot["parentchildname"];
     password = QueryDocumentSnapshot["password"];
  }


}
