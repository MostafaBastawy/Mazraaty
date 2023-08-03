class PaymentModel {
  bool? status;
  String? msg;
  Data? data;

  PaymentModel({this.status, this.msg, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  String? aboutUs;
  String? zainNumber;
  String? bankAcountNumber;
  String? iban;
  String? whatsApp;

  Data({this.aboutUs, this.zainNumber, this.bankAcountNumber, this.iban,this.whatsApp});

  Data.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
    zainNumber = json['zain_number'];
    bankAcountNumber = json['bank_acount_number'];
    iban = json['iban'];
    whatsApp = json['whatsup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about_us'] = this.aboutUs;
    data['zain_number'] = this.zainNumber;
    data['bank_acount_number'] = this.bankAcountNumber;
    data['iban'] = this.iban;
    data['whatsup'] = this.whatsApp;
    return data;
  }
}
