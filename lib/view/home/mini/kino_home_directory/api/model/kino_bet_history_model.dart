class KinoBetHistoryModel {
  dynamic  id;
  dynamic  gameId;
  dynamic  gamesno;
  dynamic  amount;
  dynamic  selectedNumbers;
  dynamic  number;
  dynamic  riskLevel;
  dynamic  multiplier;
  dynamic  winAmount;

  KinoBetHistoryModel(
      {this.id,
        this.gameId,
        this.gamesno,
        this.amount,
        this.selectedNumbers,
        this.number,
        this.riskLevel,
        this.multiplier,
        this.winAmount,
      });

  KinoBetHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    gamesno = json['games_no'];
    amount = json['amount'];
    selectedNumbers = json['selected_numbers'];
    number = json['number'];
    riskLevel = json['risk_level'];
    multiplier = json['multiplier'];
    winAmount = json['win_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> KinoBetHistoryModel = <String, dynamic>{};
    KinoBetHistoryModel['id'] = id;

    KinoBetHistoryModel['game_id'] = gameId;
    KinoBetHistoryModel['games_no'] = gamesno;
    KinoBetHistoryModel['amount'] = amount;
    KinoBetHistoryModel['selected_numbers'] = selectedNumbers;
    KinoBetHistoryModel['number'] = number;
    KinoBetHistoryModel['risk_level'] = riskLevel;
    KinoBetHistoryModel['multiplier'] = multiplier;
    KinoBetHistoryModel['win_amount'] = winAmount;

    return KinoBetHistoryModel;
  }
}
