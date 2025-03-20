class GetAmountModel {
 dynamic status;
  dynamic message;
  Data? data;

  GetAmountModel({this.status, this.message, this.data});

  GetAmountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic winAmount;
  dynamic totalAmount;

  Data({this.winAmount, this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    winAmount = json['total_win_amount'];
    totalAmount = json['total_bet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_win_amount'] = winAmount;
    data['total_bet_amount'] = totalAmount;
    return data;
  }
}
