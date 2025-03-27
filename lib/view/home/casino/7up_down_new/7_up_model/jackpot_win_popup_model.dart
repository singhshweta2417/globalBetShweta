class JackpotWinPopupModel {
  dynamic status;
  dynamic win;
  dynamic gamesNo;
  dynamic result;
  dynamic gameid;
  dynamic number;

  JackpotWinPopupModel(
      {this.status,
        this.win,
        this.gamesNo,
        this.result,
        this.gameid,
        this.number});

  JackpotWinPopupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    win = json['win'];
    gamesNo = json['games_no'];
    result = json['result'];
    gameid = json['gameid'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['win'] = win;
    data['games_no'] = gamesNo;
    data['result'] = result;
    data['gameid'] = gameid;
    data['number'] = number;
    return data;
  }
}
