// class ActivityRecordModel {
//   dynamic id;
//   dynamic name;
//   dynamic rangeAmount;
//   dynamic amount;
//   dynamic status;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic betAmount;
//
//   ActivityRecordModel(
//       {this.id,
//         this.name,
//         this.rangeAmount,
//         this.amount,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.betAmount,
//       });
//
//   ActivityRecordModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     rangeAmount = json['range_amount'];
//     amount = json['amount'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     betAmount = json['bet_amount'];
//   }}


class ActivityRecordModel {
  dynamic activityId;
  dynamic amount;
  dynamic rangeAmount;
  dynamic status;
  dynamic createdAt;
  dynamic name;

  ActivityRecordModel(
      {this.activityId,
        this.amount,
        this.rangeAmount,
        this.status,
        this.createdAt,
        this.name,
      });

  ActivityRecordModel.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    amount = json['amount'];
    rangeAmount = json['range_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
  }


}
