class msg_model {
  String? msg;
  String? date;
  String? send_or_recive;
  String? receiver;
  String? sender;
  bool? isseen;

  msg_model(
      {this.date,
      this.isseen,
      this.msg,
      this.receiver,
      this.send_or_recive,
      this.sender});

  msg_model.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isseen = json['is_seen'];
    msg = json['msg'];
    receiver = json['receiver'];
    send_or_recive = json['send_or_recive'];
    sender = json['sender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['is_seen'] = this.isseen;
    data['msg'] = this.msg;
    data['receiver'] = this.receiver;
    data['send_or_recive'] = this.send_or_recive;
    data['sender'] = this.sender;
    return data;
  }
}