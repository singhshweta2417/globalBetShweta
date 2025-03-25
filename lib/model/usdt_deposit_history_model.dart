class USDTDepositModel {
  final String? actualAmount;
  final String? amount;
  final String? createdAt;
  final String? id;
  final String? status;


  USDTDepositModel({
    required this.actualAmount,
    required this.amount,
    required this.createdAt,
    required this.id,
    required this.status,
  });
  factory USDTDepositModel.fromJson(Map<String, dynamic> json) {
    return USDTDepositModel(
      actualAmount: json['actual_amount'],
      amount: json['amount'],
      createdAt: json['created_at'],
      id: json['id'],
      status: json['status'],
    );
  }
}