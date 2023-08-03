import 'package:flutter/material.dart';

class PlacesAttributesV2Model {
  bool? status;
  String? msg;
  List<AttributeV2>? data;

  PlacesAttributesV2Model({this.status, this.msg, this.data});

  PlacesAttributesV2Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AttributeV2>[];
      json['data'].forEach((v) {
        data!.add(new AttributeV2.fromJson(v));
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

class AttributeV2 {
  int? id;
  String? name;
  TextEditingController? controller;

  AttributeV2({this.id, this.name});

  AttributeV2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
