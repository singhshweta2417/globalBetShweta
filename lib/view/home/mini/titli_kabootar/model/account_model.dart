class AccountViewModel {
  String? status;
  String? message;
  List<Data>? data;

  AccountViewModel({this.status, this.message, this.data});

  AccountViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic accountNumber;
  dynamic branch;
  dynamic bankName;
  dynamic ifscCode;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userId;
  dynamic upi;

  Data(
      {this.id,
        this.name,
        this.accountNumber,
        this.branch,
        this.bankName,
        this.ifscCode,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.upi
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNumber = json['account_number'];
    branch = json['branch'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    upi = json['upi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['account_number'] = accountNumber;
    data['branch'] = branch;
    data['bank_name'] = bankName;
    data['ifsc_code'] = ifscCode;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    data['upi'] = upi;
    return data;
  }
}
