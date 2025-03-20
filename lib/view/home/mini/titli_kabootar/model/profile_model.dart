class ProfileModel {
  bool? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic username;
  dynamic mobile;
  dynamic wallet;
  dynamic winningWallet;
  dynamic userimage;
  dynamic withdrawBalance;
  dynamic referralCode;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.username,
        this.mobile,
        this.wallet,
        this.winningWallet,
        this.userimage,
        this.withdrawBalance,
        this.referralCode,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobile = json['mobile'];
    wallet = json['wallet'];
    winningWallet = json['winning_wallet'];
    userimage = json['userimage'];
    withdrawBalance = json['withdraw_balance'];
    referralCode = json['referral_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['mobile'] = mobile;
    data['wallet'] = wallet;
    data['winning_wallet'] = winningWallet;
    data['userimage'] = userimage;
    data['withdraw_balance'] = withdrawBalance;
    data['referral_code'] = referralCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
