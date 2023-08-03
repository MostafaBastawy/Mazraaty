class NotificationsModel {
  bool? status;
  String? msg;
  List<Data>? data;

  NotificationsModel({this.status, this.msg, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? message;
  String? placeName;

  Data({this.id, this.message, this.placeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    placeName = json['palceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['palceName'] = this.placeName;
    return data;
  }
}
