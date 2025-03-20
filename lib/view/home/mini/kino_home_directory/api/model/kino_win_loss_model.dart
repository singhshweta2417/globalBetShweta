class KinoWinLossModel {
  dynamic message;
  dynamic status;
  dynamic win;
  dynamic gamesNo;
  dynamic result;
  dynamic gameId;
  Number? number;

  KinoWinLossModel(
      {this.message,
        this.status,
        this.win,
        this.gamesNo,
        this.result,
        this.gameId,
        this.number});

  KinoWinLossModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    win = json['win'];
    gamesNo = json['games_no'];
    result = json['result'];
    gameId = json['gameid'];
    number =
    json['number'] != null ? Number.fromJson(json['number']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['win'] = win;
    data['games_no'] = gamesNo;
    data['result'] = result;
    data['gameid'] = gameId;
    if (number != null) {
      data['number'] = number!.toJson();
    }
    return data;
  }
}

class Number {
  dynamic i0;
  dynamic i5;
  dynamic i6;

  Number({this.i0, this.i5, this.i6});

  Number.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    i5 = json['5'];
    i6 = json['6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['0'] = i0;
    data['5'] = i5;
    data['6'] = i6;
    return data;
  }
}
