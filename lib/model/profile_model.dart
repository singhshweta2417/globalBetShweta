class ProfileModel {
  dynamic status;
  dynamic message;
  dynamic id;
  dynamic mobile;
  dynamic email;
  dynamic username;
  dynamic userimage;
  dynamic recharge;
  dynamic uId;
  dynamic referralCode;
  dynamic mainWallet;
  dynamic thirdPartyWallet;
  dynamic totalWallet;
  dynamic winningAmount;
  dynamic minimumWithdraw;
  dynamic maximumWithdraw;
  dynamic lastLoginTime;
  dynamic apkLink;
  dynamic referralCodeUrl;
  dynamic aviatorLink;
  dynamic aviatorEventName;

  ProfileModel(
      {this.status,
        this.message,
        this.id,
        this.mobile,
        this.email,
        this.username,
        this.userimage,
        this.recharge,
        this.uId,
        this.referralCode,
        this.mainWallet,
        this.thirdPartyWallet,
        this.totalWallet,
        this.winningAmount,
        this.minimumWithdraw,
        this.maximumWithdraw,
        this.lastLoginTime,
        this.apkLink,
        this.referralCodeUrl,
        this.aviatorLink,
        this.aviatorEventName});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    mobile = json['mobile'];
    email = json['email'];
    username = json['username'];
    userimage = json['userimage'];
    recharge = json['recharge'];
    uId = json['u_id'];
    referralCode = json['referral_code'];
    mainWallet = json['main_wallet'];
    thirdPartyWallet = json['third_party_wallet'];
    totalWallet = json['total_wallet'];
    winningAmount = json['winning_amount'];
    minimumWithdraw = json['minimum_withdraw'];
    maximumWithdraw = json['maximum_withdraw'];
    lastLoginTime = json['last_login_time'];
    apkLink = json['apk_link'];
    referralCodeUrl = json['referral_code_url'];
    aviatorLink = json['aviator_link'];
    aviatorEventName = json['aviator_event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['id'] = id;
    data['mobile'] = mobile;
    data['email'] = email;
    data['username'] = username;
    data['userimage'] = userimage;
    data['recharge'] = recharge;
    data['u_id'] = uId;
    data['referral_code'] = referralCode;
    data['main_wallet'] = mainWallet;
    data['third_party_wallet'] = thirdPartyWallet;
    data['total_wallet'] = totalWallet;
    data['winning_amount'] = winningAmount;
    data['minimum_withdraw'] = minimumWithdraw;
    data['maximum_withdraw'] = maximumWithdraw;
    data['last_login_time'] = lastLoginTime;
    data['apk_link'] = apkLink;
    data['referral_code_url'] = referralCodeUrl;
    data['aviator_link'] = aviatorLink;
    data['aviator_event_name'] = aviatorEventName;
    return data;
  }
}
