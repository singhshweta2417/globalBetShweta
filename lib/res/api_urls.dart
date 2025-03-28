class ApiUrl {
  static const String uploadImage = "${baseUrl}admin/uploads/";
  static const String baseUrl = 'https://root.gameon.deals/';
  static const String configModel = "${baseUrl}api/";
  static const String login = "${configModel}login";
  static const String register = "${configModel}register";
  static const String profileUrl = "${configModel}profile?id=";
  static const String allTransactionType =
      "${configModel}transaction_history_list";
  static const String allTransaction =
      "${configModel}transaction_history?userid=";
  static const String depositWithdrawlStatusList = "${configModel}Status_list";

  static const String depositHistory = "${configModel}deposit_history?user_id=";

  static const String withdrawHistory =
      "${configModel}withdraw_history?user_id=";
  static const String indianPayDeposit = "${configModel}payin";
  static const String deposit = "${configModel}usdt_payin";

  static const String addacount = "${configModel}add_account";
  static const String addAccountView = "${configModel}Account_view?user_id=";
  static const String withdrawl = "${configModel}withdraw";
  static const String usdtWithdrawl = "${configModel}usdtwithdraw";
  static const String giftHistory = "${configModel}claim_list?userid=";
  static const String privacyPolicy = "${configModel}privacy_policy";
  static const String customerService = "${configModel}customer_service";
  static const String changeAviatorList = "${configModel}image_all";
  static const String updateAviatorApi = "${configModel}update_avatar";
  static const String changePasswordApi = "${configModel}changePassword";
  static const String banner = "${configModel}slider_image_view";
  static const String mainWalletTransfer = "${configModel}main_wallet_transfer";

  static const String activityRewards =
      "${configModel}activity_rewards?userid=";
  static const String activityClaimRewards =
      "${configModel}activity_rewards_claim";

  static const String activityRewardsHistory =
      "${configModel}activity_rewards_history?userid=";

  static const String invitationBonusList =
      "${configModel}invitation_bonus_list?userid=";
  static const String invitationRecords =
      "${configModel}Invitation_records?userid=";
  static const String extraDeposit =
      "${configModel}extra_first_deposit_bonus?userid=";
  static const String offer = "${configModel}getAllNotices";
  static const String country = "${configModel}country";
  static const String attendanceList = "${configModel}attendance_List?userid=";
  static const String attendanceHistory =
      "${configModel}attendance_history?userid=";
  static const String attendanceClaim = "${configModel}attendance_claim";
  static const String promotionScreen = "${configModel}agency-promotion-data-";
  static const String newSubordinateTabApi =
      "${configModel}new-subordinate?id=";
  static const String tierApi = "${configModel}tier";
  static const String subDataApi = "${configModel}subordinate-data?id=";
  static const String commissionDetailApi =
      "${configModel}commission_details?userid=";
  static const String allRules = "${configModel}all_rules?type=";
  static const String bettingRebateApi =
      "${configModel}betting_rebate_history?userid=";

  static const String aviatorBet = "${configModel}aviator_bet_new?uid=";
  static const String aviatorBetCancel =
      "${configModel}aviator_bet_cancel?userid=";
  static const String aviatorBetCashOut = "${configModel}aviator_cashout?salt=";
  static const String aviatorResult = "${configModel}aviator_last_five_result";
  static const String aviatorBetHistory = "${configModel}aviator_history?uid=";

  static const String resultList = "${configModel}results?game_id=";
  static const String betHistory = "${configModel}bet_history?userid=";
  static const String bettingApi = "${configModel}bets";//bet
  static const String gameWin = "${configModel}win_amount?userid=";
  static const String dragonBet = "${configModel}dragon_bet";

  static const String promotionCount =
      "${configModel}promotion_dashboard_count?id=";
  static const String walletDash = "${configModel}wallet_dashboard?id=";
  static const String aboutus = "${configModel}about_us?";
  static const String howToPlayApi =
      "${baseUrl}admin/index.php/Mobile_app/howtoplay?game_id=";
  static const String beginnerApi = "${configModel}beginner_guied_line";
  static const String notificationApi = "${configModel}notification";
  static const String giftCardApi = "${configModel}giftCartApply?";
  static const String coinsApi = "${configModel}coins";
  static const String mlm = "${configModel}level_getuserbyrefid?id=";
  static const String feedback = "${configModel}feedback";
  static const String versionLink = "${configModel}version_apk_link";
  static const String profileUpdate = "${configModel}update_profile";

  static const String getWayList = "${configModel}pay_modes";
  static const String planMlm = "${configModel}mlm_plan";
  static const String termsCon = "${configModel}terms_condition";
  static const String contact = "${configModel}contact_us";
  static const String attendanceGet = "${configModel}attendance?";
  static const String attendanceDays = "${configModel}attendance_claim?userid=";
  static const String mlmPlan = "${configModel}level_getuserbyrefid?id=";
  static const String walletHistory = "${configModel}wallet_history?userid=";
  static const String paymentCheckStatus =
      "${configModel}payment_verified_done?orderid=";
  static const String extraDepositPayment =
      "${configModel}extra_first_deposit?";

  static const String usdtDeposit =
      "https://winzy.live/admin/api/pending_payment.php";
  static const String usdtDepositHistory =
      "https://winzy.live/admin/api/pendingPayment_history.php?";
  static const String usdtQrcodeApi =
      "https://winzy.live/admin/index.php/Mahajongapi/usdt_slider";
  static const String usdtQrcodeImage =
      "https://admin.winzy.live/images/1711803944_IMG_20240330_180436.jpg";
  static const String userBlock = "https://admin.winzy.live/api/auth-check-";

  static const String sendOtp = "https://otp.fctechteam.org/send_otp.php?";
  static const String verifyOtp =
      "https://otp.fctechteam.org/verifyotp.php?mobile=";
  static const String forgetPasswordUrl =
      "https://root.game_on24.live/api/forget_pass";

  static const String plinkoBet = "${configModel}plinko_bet_new";
  static const String plinkoList = "${configModel}plinko_index_list?type=";
  static const String plinkoMultiplier = "${configModel}plinko_multiplier";
  static const String plinkoBetHistory = "${configModel}plinko_result?";

  ///andarBahar

  static const String gameHistory = '${configModel}bet_history?game_id=';
  static const String result = '${baseUrl}api/results?game_id=';
  static const String betPlaced = '${baseUrl}api/bet';
  static const String winAmount = '${baseUrl}api/win-amount?userid=';

  ///head tails

  static const String gameRules = '${baseUrl}api/rules?game_id=';

  ///vip
  static const String vipLevel = "${configModel}vip_level?userid=";
  static const String addMoney = "${configModel}add_money";
  static const String vipHistory = "${configModel}vip_level_history?userid=";

  static const String bonusClaim = "${configModel}invitation_bonus_claim";
  static const String depositCamLenio = "${configModel}camlenio?user_id=";
}
