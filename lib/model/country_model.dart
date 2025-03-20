class CountryCodeModel {
  String? status;
  List<Data>? data;

  CountryCodeModel({this.status, this.data});

  CountryCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic sortname;
  dynamic name;
  dynamic phoneCode;

  Data({this.id, this.sortname, this.name, this.phoneCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortname = json['sortname'];
    name = json['name'];
    phoneCode = json['phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sortname'] = sortname;
    data['name'] = name;
    data['phone_code'] = phoneCode;
    return data;
  }
}
