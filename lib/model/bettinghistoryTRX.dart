// ignore_for_file: non_constant_identifier_names

class BettingHistoryModelTRX {
  final String? amount;
  final String? color;
  final String? commission;
  final String? datetime;
  final int ? gameid;
  final String? gamesno;
  final int ? id;
  final String? number;
  final String? status;
  final String? sub_number;
  final String? totalamount;
  final String? userid;
  final String? win;

  BettingHistoryModelTRX({
    required this.amount,
    required this.color,
    required this.commission,
    required this.datetime,
    required this.gameid,
    required this.gamesno,
    required this.id,
    required this.number,
    required this.status,
    required this.sub_number,
    required this.totalamount,
    required this.userid,
    required this.win,

  });
  factory BettingHistoryModelTRX.fromJson(Map<String, dynamic> json) {
    return BettingHistoryModelTRX(
      amount: json['amount'],
      color: json['color'],
      commission: json['commission'],
      datetime: json['datetime'],
      gameid: json['gameid'],
      gamesno: json['gamesno'],
      id: json['id'],
      number: json['number'],
      status: json['status'],
      sub_number: json['sub_number'],
      totalamount: json['totalamount'],
      userid: json['userid'],
      win: json['win'],

    );
  }
}