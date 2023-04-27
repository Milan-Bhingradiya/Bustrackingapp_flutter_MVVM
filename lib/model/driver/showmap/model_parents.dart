class modelofparents {
   String? parentname;
   String? parentchildname;
   int? parentphonenumber;
   String? password;
   double? lat;
   double? long;
   final QueryDocumentSnapshot;

  modelofparents(this.QueryDocumentSnapshot) {
    
    lat = QueryDocumentSnapshot["letitude"];
    long = QueryDocumentSnapshot["longitude"];
    parentname = QueryDocumentSnapshot["parentname"];
    parentchildname = QueryDocumentSnapshot["parentchildname"];
    password = QueryDocumentSnapshot["password"];
  }
}
