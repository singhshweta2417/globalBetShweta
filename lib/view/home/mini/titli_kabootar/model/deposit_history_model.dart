class DepositHistoryModel {
  String? message;
  bool? status;
  List<Data>? data;

  DepositHistoryModel({this.message, this.status, this.data});

  DepositHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
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
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic cash;
  dynamic status;
  dynamic orderId;
  dynamic typeimage;
  dynamic createdAt;

  Data({this.cash, this.status, this.orderId, this.typeimage, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
    status = json['status'];
    orderId = json['order_id'];
    typeimage = json['typeimage'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cash'] = cash;
    data['status'] = status;
    data['order_id'] = orderId;
    data['typeimage'] = typeimage;
    data['created_at'] = createdAt;
    return data;
  }
}
