class PlacesAttributesV1Model {
  bool? status;
  String? msg;
  List<AttributeV1>? data;

  PlacesAttributesV1Model({this.status, this.msg, this.data});

  PlacesAttributesV1Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AttributeV1>[];
      json['data'].forEach((v) {
        data!.add(new AttributeV1.fromJson(v));
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

class AttributeV1 {
  int? id;
  String? name;
  bool status = false;

  AttributeV1({this.id, this.name});

  AttributeV1.fromJson(Map<String, dynamic> json) {
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
