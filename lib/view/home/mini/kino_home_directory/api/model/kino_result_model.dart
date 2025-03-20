class KinoResultModel {
  dynamic id;
  dynamic userId;
  dynamic gameId;
  dynamic gamesno;
  dynamic number;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic gameName;
  dynamic gameNumber;
  dynamic gameGameid;
  dynamic gameSettingName;

  KinoResultModel(
      {this.id,
        this.userId,
        this.gameId,
        this.gamesno,
        this.number,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.gameName,
        this.gameNumber,
        this.gameGameid,
        this.gameSettingName});

  KinoResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gameId = json['game_id'];
    gamesno = json['games_no'];
    number = json['number'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gameName = json['game_name'];
    gameNumber = json['game_number'];
    gameGameid = json['game_gameid'];
    gameSettingName = json['game_setting_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> KinoResultModel = <String, dynamic>{};
    KinoResultModel['id'] = id;
    KinoResultModel['user_id'] = userId;
    KinoResultModel['game_id'] = gameId;
    KinoResultModel['games_no'] = gamesno;
    KinoResultModel['number'] = number;
    KinoResultModel['status'] = status;
    KinoResultModel['created_at'] = createdAt;
    KinoResultModel['updated_at'] = updatedAt;
    KinoResultModel['game_name'] = gameName;
    KinoResultModel['game_number'] = gameNumber;
    KinoResultModel['game_gameid'] = gameGameid;
    KinoResultModel['game_setting_name'] = gameSettingName;
    return KinoResultModel;
  }
}
