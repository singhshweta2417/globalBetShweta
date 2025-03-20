class MyBetModel {
  final dynamic id;
  final dynamic uid;
  final dynamic amount;
  final dynamic stopMultiplier;
  final dynamic gameId;
  final dynamic totalAmount;
  final dynamic number;
  final dynamic subNumber;
  final dynamic color;
  final dynamic gameSrNum;
  final dynamic commission;
  final dynamic status;
  final dynamic resultStatus;
  final dynamic win;
  final dynamic multiplier;
  final dynamic datetime;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic cashoutAmount;

  MyBetModel({
     this.id,
     this.uid,
     this.amount,
     this.stopMultiplier,
     this.gameId,
     this.totalAmount,
     this.number,
    this.subNumber,
    this.color,
     this.gameSrNum,
     this.commission,
     this.status,
     this.resultStatus,
     this.win,
     this.multiplier,
     this.datetime,
     this.createdAt,
     this.updatedAt,
     this.cashoutAmount,
  });

  factory MyBetModel.fromJson(Map<String, dynamic> json) {
    return MyBetModel(
      id: json['id'],
      uid: json['uid'],
      amount: json['amount'].toDouble(),
      stopMultiplier: json['stop_multiplier'].toDouble(),
      gameId: json['game_id'],
      totalAmount: json['totalamount'].toDouble(),
      number: json['number'],
      subNumber: json['sub_number'],
      color: json['color'],
      gameSrNum: json['game_sr_num'],
      commission: json['commission'].toDouble(),
      status: json['status'],
      resultStatus: json['result_status'],
      win: json['win'].toDouble(),
      multiplier: json['multiplier'].toDouble(),
      datetime: json['datetime'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cashoutAmount: json['cashout_amount'].toDouble(),
    );
  }
}

