class WithdrawHistoryModel {
  String? message;
  bool? status;
  List<Data>? data;

  WithdrawHistoryModel({this.message, this.status, this.data});

  WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic userId;
  dynamic amount;
  dynamic type;
  dynamic status;
  dynamic typeimage;
  dynamic orderId;
  dynamic createdAt;

  Data(
      {this.id,
        this.userId,
        this.amount,
        this.type,
        this.status,
        this.typeimage,
        this.orderId,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    typeimage = json['typeimage'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['type'] = type;
    data['status'] = status;
    data['typeimage'] = typeimage;
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    return data;
  }
}
