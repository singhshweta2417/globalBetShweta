class PlinkoBetHistory {
  dynamic id;
  dynamic userid;
  dynamic amount;
  dynamic type;
  dynamic multipler;
  dynamic winAmount;
  dynamic status;
  dynamic datetime;
  dynamic tax;
  dynamic afterTax;
  dynamic orderid;


  PlinkoBetHistory({
    required this.id,
    required this.userid,
    required this.amount,
    required this.type,
    required this.multipler,
    required this.winAmount,
    required this.status,
    required this.datetime,
    required this.tax,
    required this.afterTax,
    required this.orderid,

  });
  factory PlinkoBetHistory.fromJson(Map<String, dynamic> json) {
    return PlinkoBetHistory(
      id: json['id'],
      userid: json['userid'],
      amount: json['amount'],
      type: json['type'],
      multipler: json['multipler'],
      winAmount: json['win_amount'],
      status: json['status'],
      datetime: json['created_at'],
      tax: json['tax'],
      afterTax: json['after_tax'],
      orderid: json['orderid'],

    );
  }
}