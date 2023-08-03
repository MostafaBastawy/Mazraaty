class SlidersModel {
  SlidersModel({
    required this.status,
    required this.msg,
    required this.slides,
  });
  late final bool status;
  late final String msg;
  late final List<Slides> slides;

  SlidersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    slides = List.from(json['data']).map((e) => Slides.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = slides.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Slides {
  Slides({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String link;
  late final String image;

  Slides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['link'] = link;
    _data['image'] = image;
    return _data;
  }
}
