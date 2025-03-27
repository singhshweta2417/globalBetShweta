class JackpotResultModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  JackpotResultModel({this.status, this.message, this.data});

  JackpotResultModel.fromJson(Map<String, dynamic> json) {
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
  dynamic json2;
  dynamic randomCard;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.number,
        this.gamesNo,
        this.gameId,
        this.json2,
        this.randomCard,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    gamesNo = json['games_no'];
    gameId = json['game_id'];
    json2 = json['json'];
    randomCard = json['random_card'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['games_no'] = gamesNo;
    data['game_id'] = gameId;
    data['json'] = json2;
    data['random_card'] = randomCard;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
