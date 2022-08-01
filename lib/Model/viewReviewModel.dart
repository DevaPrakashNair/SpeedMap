class ViewReviewModel {
  ViewReviewModel({
      this.status, 
      this.msg, 
      this.data,});

  ViewReviewModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.review, 
      this.datetime, 
      this.location, 
      this.role, 
      this.status, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    review = json['review'];
    datetime = json['datetime'];
    location = json['location'];
    role = json['role'];
    status = json['status'];
    v = json['__v'];
  }
  String? id;
  String? review;
  String? datetime;
  String? location;
  String? role;
  String? status;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['review'] = review;
    map['datetime'] = datetime;
    map['location'] = location;
    map['role'] = role;
    map['status'] = status;
    map['__v'] = v;
    return map;
  }

}