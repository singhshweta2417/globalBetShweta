class WalletModel {
  final String? wallet;
  final String? winningWallet;
  final String? commission;
  final String? bonus;
  final String? salary;


  WalletModel({
    required this.wallet,
    required this.winningWallet,
    required this.commission,
    required this.bonus,
    required this.salary,

  });
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      wallet: json['wallet'],
      winningWallet: json['winning_wallet'],
      commission: json['commission'],
      bonus: json['bonus'],
      salary: json['salary'],

    );
  }
}