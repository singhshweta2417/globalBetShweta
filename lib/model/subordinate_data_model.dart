class SubordinateModel {
  dynamic id;
  dynamic uId;
  dynamic betAmount;
  dynamic totalCash;
  dynamic commission;
  dynamic yesterdayDate;


  SubordinateModel({
    required this.id,
    required this.uId,
    required this.betAmount,
    required this.totalCash,
    required this.commission,
    required this.yesterdayDate,

  });
  factory SubordinateModel.fromJson(Map<String, dynamic> json) {
    return SubordinateModel(
      id: json['id'],
      uId: json['u_id'],
      betAmount: json['bet_amount'],
      totalCash: json['total_cash'],
      commission: json['commission'],
      yesterdayDate: json['yesterday_date'],

    );
  }
}