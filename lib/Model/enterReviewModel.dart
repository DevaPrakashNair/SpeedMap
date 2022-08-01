class EnterReviewModel {
  EnterReviewModel({
      this.status, 
      this.msg, 
      this.data,});

  EnterReviewModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.review, 
      this.datetime, 
      this.location, 
      this.role, 
      this.status, 
      this.id, 
      this.v,});

  Data.fromJson(dynamic json) {
    review = json['review'];
    datetime = json['datetime'];
    location = json['location'];
    role = json['role'];
    status = json['status'];
    id = json['_id'];
    v = json['__v'];
  }
  String? review;
  String? datetime;
  String? location;
  String? role;
  String? status;
  String? id;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review'] = review;
    map['datetime'] = datetime;
    map['location'] = location;
    map['role'] = role;
    map['status'] = status;
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }

}