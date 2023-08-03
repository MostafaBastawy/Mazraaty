class RateModel {
  RateModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final Data data;

  RateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.rateId,
    required this.placeId,
  });
  late final int rateId;
  late final String placeId;

  Data.fromJson(Map<String, dynamic> json) {
    rateId = json['rate_id'];
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rate_id'] = rateId;
    _data['place_id'] = placeId;
    return _data;
  }
}
