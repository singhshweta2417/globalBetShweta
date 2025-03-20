class ResultModel {
  bool? status;
  String? message;
  List<Data>? data;

  ResultModel({this.status, this.message, this.data});

  ResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic number;
  dynamic gamesNo;
  dynamic gameId;
  dynamic image;
  dynamic json1;
  dynamic cardId;
  dynamic cardName;
  dynamic multiplier;
  dynamic token;
  dynamic block;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic gameName;
  dynamic gameNumber;
  dynamic gameGameid;
  dynamic gameSettingName;

  Data(
      {this.id,
        this.number,
        this.gamesNo,
        this.gameId,
        this.image,
        this.json1,
        this.cardId,
        this.cardName,
        this.multiplier,
        this.token,
        this.block,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.gameName,
        this.gameNumber,
        this.gameGameid,
        this.gameSettingName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    gamesNo = json['games_no'];
    gameId = json['game_id'];
    image = json['image'];
    json1 = json['json'];
    cardId = json['card_id'];
    cardName = json['card_name'];
    multiplier = json['multiplier'];
    token = json['token'];
    block = json['block'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gameName = json['game_name'];
    gameNumber = json['game_number'];
    gameGameid = json['game_gameid'];
    gameSettingName = json['game_setting_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['games_no'] = gamesNo;
    data['game_id'] = gameId;
    data['image'] = image;
    data['json'] = json1;
    data['card_id'] = cardId;
    data['card_name'] = cardName;
    data['multiplier'] = multiplier;
    data['token'] = token;
    data['block'] = block;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['game_name'] = gameName;
    data['game_number'] = gameNumber;
    data['game_gameid'] = gameGameid;
    data['game_setting_name'] = gameSettingName;
    return data;
  }
}
