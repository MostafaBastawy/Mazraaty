class Places {
  bool? status;
  String? msg;
  Data? data;

  Places({this.status, this.msg, this.data});

  Places.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<PlacesCategory>? data;
  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PlacesCategory>[];
      json['data'].forEach((v) {
        data!.add(new PlacesCategory.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlacesCategory {
  int? id;
  String? name;
  int? price;
  bool? isFav;
  String? image;

  PlacesCategory({this.id, this.name, this.price, this.isFav, this.image});

  PlacesCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isFav = json['isFav'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['isFav'] = this.isFav;
    data['image'] = this.image;
    return data;
  }
}


