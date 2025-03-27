class PromotionCountModel {

  String? totalUserCount;
  String? todayUser;
  String? totalCommission;
  String? referBonus;

  PromotionCountModel({
    required this.totalUserCount,
    required this.todayUser,
    required this.totalCommission,
    required this.referBonus,

  });

  factory PromotionCountModel.fromJson(Map<String, dynamic>json) {
    return PromotionCountModel(
      totalUserCount: json['total_user_count'],
      todayUser: json['today_user'],
      totalCommission: json['total_commission'],
      referBonus: json['refer_bonus'],

    );
  }
}
