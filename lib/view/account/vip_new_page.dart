import 'dart:convert';
import 'package:globalbet/model/vip_bet_card/vip_his_model.dart';
import 'package:globalbet/res/provider/vip_card_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/model/vip_bet_card/model.dart';
import 'package:globalbet/plinko/utils/plinko_pop_up.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/account/vip_history.dart';
import 'package:globalbet/view/home/mini/Aviator/progressbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class VipScreenNew extends StatefulWidget {
  const VipScreenNew({super.key});

  @override
  State<VipScreenNew> createState() => _VipScreenNewState();
}

class _VipScreenNewState extends State<VipScreenNew> {
  @override
  void initState() {
    super.initState();
    vipBetCardsData();
    vipHistoryList();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List<VipRule> ruleData = [
    VipRule(
      title: 'Upgrade standard',
      discription:
          "The IP member's experience points (valid bet amount) that meet the requirements of the corresponding rank will be promoted to the corresponding VIP level, the member's VIP data statistics period starts from 00:00:00 days VIP system launched.VIP level calculation is refreshed every 10 minutes! The corresponding experience level is calculated according to valid odds 1:1 !",
    ),
    VipRule(
        title: 'Upgrade order',
        discription:
            "The VIP level that meets the corresponding requirements can be promoted by one level every day, but the VIP level cannot be promoted by leapfrogging."),
    VipRule(
        title: 'Level maintenance',
        discription:
            'VIP members need to complete the maintenance requirements of the corresponding level within 30 days after the "VIP level change"; if the promotion is completed during this period, the maintenance requirements will be calculated according to the current level.'),
    VipRule(
        title: 'Downgrade standard',
        discription:
            "If a VIP member fails to complete the corresponding level maintenance requirements within 30 days, the system will automatically deduct the experience points corresponding to the level. If the experience points are insufficient, the level will be downgraded, and the corresponding discounts will be adjusted to the downgraded level accordingly."),
    VipRule(
        title: 'Upgrade Bonus',
        discription:
            "The upgrade benefits can be claimed on the VIP page after the member reaches the VIP membership level, and each VIP member can only get the upgrade reward of each level once."),
    VipRule(
        title: 'Monthly reward',
        discription:
            "VIP members can earn the highest level of VIP rewards once a month.Can only be received once a month. Prizes cannot be accumulated. And any unclaimed rewards will be refreshed on the next settlement day. When receiving the highest level of monthly rewards this month Monthly Rewards earned in this month will be deducted e.g. when VIP1 earns 500 and upgrades to VIP2 to receive monthly rewards 500 will be deducted."),
    VipRule(
        title: 'Real-time rebate',
        discription:
            "The higher the VIP level, the higher the return rate, all the games are calculated in real time and can be self-rewarded!"),
    VipRule(
        title: 'Safe',
        discription:
            "VIP members who have reached the corresponding level will get additional benefits on safe deposit based on the member's VIP level."),
  ];

  List<VipLevel> vipLevel = [
    VipLevel(
      bgImage: Assets.iconsVipbg1,
      title: 'Vip1',
      achievedImg: Assets.iconsViptick,
      topImg: Assets.iconsViptop1,
      levelImage: Assets.iconsVip1,
      targetNumber: '60',
      achievedNumber: '60',
      completePercentage: '0.00',
      bottomColor: AppColors.vip1,
      status: '1',
      backGroundColor: AppColors.vipColor1,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg2,
      title: 'Vip2',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip2,
      targetNumber: '30000',
      achievedNumber: '70',
      completePercentage: '80.0',
      bottomColor: AppColors.vip2,
      status: '0',
      backGroundColor: AppColors.vipColor2,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg3,
      title: 'Vip3',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip3,
      targetNumber: '40000',
      achievedNumber: '70',
      completePercentage: '30.0',
      bottomColor: AppColors.vip3,
      status: '0',
      backGroundColor: AppColors.vipColor3,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg4,
      title: 'Vip4',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip4,
      targetNumber: '50000',
      achievedNumber: '70',
      completePercentage: '10.0',
      bottomColor: AppColors.vip4,
      status: '0',
      backGroundColor: AppColors.vipColor4,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg5,
      title: 'Vip5',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip5,
      targetNumber: '75000',
      achievedNumber: '70',
      completePercentage: '8.2',
      bottomColor: AppColors.vip5,
      status: '0',
      backGroundColor: AppColors.vipColor5,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg6,
      title: 'Vip6',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip6,
      targetNumber: '80000',
      achievedNumber: '70',
      completePercentage: '7.6',
      bottomColor: AppColors.vip6,
      status: '0',
      backGroundColor: AppColors.vipColor6,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg7,
      title: 'Vip7',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip7,
      targetNumber: '78000',
      achievedNumber: '70',
      completePercentage: '6.0',
      bottomColor: AppColors.vip7,
      status: '0',
      backGroundColor: AppColors.vipColor7,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg8,
      title: 'Vip8',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip8,
      targetNumber: '82000',
      achievedNumber: '70',
      completePercentage: '10.0',
      bottomColor: AppColors.vip8,
      status: '0',
      backGroundColor: AppColors.vipColor8,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg9,
      title: 'Vip9',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip9,
      targetNumber: '87000',
      achievedNumber: '00',
      completePercentage: '0.0',
      bottomColor: AppColors.vip9,
      status: '0',
      backGroundColor: AppColors.vipColor9,
    ),
    VipLevel(
      bgImage: Assets.iconsVipbg10,
      title: 'Vip10',
      achievedImg: Assets.iconsVipununlocked,
      topImg: Assets.iconsViptop2,
      levelImage: Assets.iconsVip10,
      targetNumber: '970000',
      achievedNumber: '00',
      completePercentage: '0.0',
      bottomColor: AppColors.vip10,
      status: '0',
      backGroundColor: AppColors.vipColor10,
    ),
  ];

  VipCardProvider vipCardProvider = VipCardProvider();

  final PageController _pageController = PageController();

  bool _isLoading = false;

  void _onPageChanged(int index) async {
    setState(() {
      _isLoading = true; // Start loading
    });

    // Simulate a network delay (replace this with actual loading logic if needed)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false; // End loading
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      
      appBar: GradientAppBar(
          title: textWidget(text: 'VIP', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                  height: height * 0.3,
                  width: width,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(userData.userImage.toString()),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Image(
                              image: const AssetImage(Assets.iconsProfilevip1),
                              height: height * 0.04,
                            ),
                            const SizedBox(height: 10),
                            textWidget(
                                text: userData.userName == ''
                                    ? "MEMBERNGKC"
                                    : userData.userName.toString(),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: height * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    topContainer(
                        myExp == null ? '00' : myExp.toString(),
                        'Exp',
                        'My Experience',
                        AppColors.whiteColor,
                        FontWeight.w500),
                    topContainer(
                        PayoutTime == null ? '00' : PayoutTime.toString(),
                        'days',
                        'Payout time',
                        AppColors.whiteColor,
                        FontWeight.w900),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(13),
            height: height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.whiteColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: textWidget(
                text:
                    'VIP level rewards are settled at 2:00 am on the 1st of every month',
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w500),
          ),
          //card
          SizedBox(
            height: height * 1.65,
            width: width * 0.3,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: betCardList.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final data = betCardList[index];
                double valueToUse = 0.0;
                double getValidatedPercentage(dynamic data) {
                  if (data.betAmount != null &&
                      data.rangeAmount != null &&
                      data.percentage != null) {
                    double betAmount = double.parse(data.betAmount.toString());
                    double rangeAmount =
                        double.parse(data.rangeAmount.toString());
                    double percentageValue = double.parse(data.percentage);
                    valueToUse =
                        (betAmount < rangeAmount) ? percentageValue : 100.0;
                    if (kDebugMode) {
                      print('valueToUse before normalization: $valueToUse');
                      print('cddddddddddddddh');
                    }
                    if (valueToUse >= 0.0 && valueToUse <= 100.0) {
                      double normalizedValue = valueToUse / 100;
                      return normalizedValue;
                    } else {
                      throw Exception(
                          'Percent value must be between 0.0 and 100.0, but it\'s $valueToUse');
                    }
                  } else {
                    throw Exception(
                        'Bet amount, range amount, or percentage is null');
                  }
                }

                double percentage = getValidatedPercentage(data);
                return Column(
                  children: [
                    _isLoading == true
                        ? Container(
                            color: Colors.black.withOpacity(0.5),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(5),
                            height: height * 0.23,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: vipLevel[index].bottomColor,
                              image: DecorationImage(
                                image: AssetImage(
                                    vipLevel[index].bgImage.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: height * 0.1,
                                        width: width * 0.52,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      vipLevel[index]
                                                          .topImg
                                                          .toString()),
                                                  height: 30,
                                                ),
                                                textWidget(
                                                  text: data.name.toString(),
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Image(
                                                  image: AssetImage(
                                                      vipLevel[index]
                                                          .achievedImg
                                                          .toString()),
                                                  height: 18,
                                                ),
                                                textWidget(
                                                  text: data.status == "1"
                                                      ? 'Achieved'
                                                      : 'UnAchieved',
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: height * 0.03,
                                              width: width * 0.32,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: textWidget(
                                                text:
                                                    ' Dear ${data.name.toString()} customer',
                                                color: Colors.white,
                                              ),
                                            ),
                                            data.status == 0
                                                ? textWidget(
                                                    text: 'Level maintenance',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.1,
                                        width: width * 0.22,
                                        child: Image(
                                          image: AssetImage(vipLevel[index]
                                              .levelImage
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                data.status == '0'
                                    ? SizedBox(
                                        height: height * 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 20,
                                                  // width: width * 0.3,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: textWidget(
                                                    text:
                                                        '  ${data.betAmount != null && data.rangeAmount != null && int.parse(data.betAmount.toString()) < int.parse(data.rangeAmount!) ? data.betAmount : data.rangeAmount}/${int.parse(data.rangeAmount!)}  ',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                textWidget(
                                                  text:
                                                      '$valueToUse% Completed',
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (kDebugMode) {
                                                  print(double.parse(
                                                          betCardList[index]
                                                              .percentage
                                                              .toString()) /
                                                      100);
                                                  print('shwetasss');
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: LinearPercentIndicator(
                                                  animation: true,
                                                  animationDuration: 1000,
                                                  lineHeight: 9.0,
                                                  percent: percentage,
                                                  progressColor:
                                                      Colors.yellow[400],
                                                  backgroundColor:
                                                      vipLevel[index]
                                                          .backGroundColor,
                                                ),
                                              ),
                                            ),
                                            textWidget(
                                              text:
                                                  '   Incomplete will be deducted by the system',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),
                                      )
                                    : textWidget(
                                        text:
                                            'Received ${data.name} level bonus',
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                              ],
                            ),
                          ),
                    if (_isLoading)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: SizedBox(),
                        ),
                      ),
                    _isLoading == true
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: AppColors.unSelectedColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(14, 14, 0, 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  Assets.iconsVipdiamond),
                                              height: 25,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            textWidget(
                                                text:
                                                    '${betCardList[index].name} Benefits level',
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ],
                                        ),
                                        const Divider(
                                          indent: 30,
                                          thickness: 1,
                                          endIndent: 20,
                                          color: AppColors.constColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                      leading: SizedBox(
                                        height: height * 0.08,
                                        width: width * 0.17,
                                        child: const Image(
                                          image:
                                              AssetImage(Assets.iconsVipgift),
                                        ),
                                      ),
                                      title: textWidget(
                                          text: 'Level up rewards',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white),
                                      subtitle: textWidget(
                                          text:
                                              'Each account can only receive 1 time\n',
                                          color: Colors.white),
                                      trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            vipBenefit(
                                              betCardList[index]
                                                  .levelUpRewards
                                                  .toString(),
                                              Assets.iconsDepoWallet,
                                            ),
                                            vipBenefit(
                                              '0',
                                              Assets.iconsViplove,
                                            )
                                          ])),
                                  ListTile(
                                      leading: SizedBox(
                                        height: height * 0.08,
                                        width: width * 0.17,
                                        child: const Image(
                                          image: AssetImage(
                                              Assets.iconsVipstarcoin),
                                        ),
                                      ),
                                      title: textWidget(
                                          text: 'Monthly rewards',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white),
                                      subtitle: textWidget(
                                          text:
                                              'Each account can only receive 1 time per month',
                                          color: Colors.white),
                                      trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            vipBenefit(
                                              betCardList[index]
                                                  .monthlyRewards
                                                  .toString(),
                                              Assets.iconsDepoWallet,
                                            ),
                                            vipBenefit(
                                              '0',
                                              Assets.iconsViplove,
                                            )
                                          ])),
                                  ListTile(
                                      leading: SizedBox(
                                        height: height * 0.08,
                                        width: width * 0.17,
                                        child: const Image(
                                          image:
                                              AssetImage(Assets.iconsVipcoins),
                                        ),
                                      ),
                                      title: textWidget(
                                          text: 'Rebate rate',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white),
                                      subtitle: textWidget(
                                          text: 'Increase income of rebate',
                                          color: Colors.white),
                                      trailing: vipBenefit(
                                          betCardList[index]
                                              .rebateRate
                                              .toString(),
                                          Assets.iconsVipweal))
                                ],
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.unSelectedColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 14, 0, 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(Assets.iconsVipcrown),
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      textWidget(
                                          text: 'My benefits',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ],
                                  ),
                                  const Divider(
                                    indent: 30,
                                    thickness: 1,
                                    endIndent: 20,
                                    color: AppColors.constColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      myBenefits(
                                          Assets.iconsVipwelfare1,
                                          betCardList[index]
                                              .levelUpRewards
                                              .toString(),
                                          Assets.iconsDepoWallet,
                                          Assets.iconsViplove,
                                          '0',
                                          'Level up rewards',
                                          'Each account can only receive 1 time\n',
                                          'Received',
                                          betCardList[index]
                                              .levelUpStatus
                                              .toString(),
                                          betCardList[index].levelUpStatus == 0
                                              ? () {}
                                              : () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          popUp(
                                                              Assets
                                                                  .iconsVipwelfare1,
                                                              'Level up rewards',
                                                              () {
                                                            addMoney(
                                                              betCardList[index]
                                                                  .id
                                                                  .toString(),
                                                              betCardList[index]
                                                                  .levelUpRewards
                                                                  .toString(),
                                                              '0',
                                                              context,
                                                            );
                                                          }));
                                                },
                                          betCardList[index].levelUpStatus == 0
                                              ? AppColors.primaryAppbarGrey
                                              : AppColors.loginSecondaryGrad,
                                          'Received'),
                                      myBenefits(
                                          Assets.iconsVipwelfare2,
                                          betCardList[index]
                                              .monthlyRewards
                                              .toString(),
                                          Assets.iconsDepoWallet,
                                          Assets.iconsViplove,
                                          '0',
                                          'Monthly rewards',
                                          'Each account can only receive 1 time per month'
                                              'Received',
                                          '',
                                          betCardList[index]
                                              .monthlyRewardsStatus
                                              .toString(),
                                          betCardList[index]
                                                      .monthlyRewardsStatus ==
                                                  0
                                              ? () {}
                                              : () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          popUp(
                                                              Assets
                                                                  .iconsVipwelfare2,
                                                              'Monthly rewards',
                                                              () {
                                                            addMoney(
                                                                betCardList[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                '0',
                                                                betCardList[
                                                                        index]
                                                                    .monthlyRewards
                                                                    .toString(),
                                                                context);
                                                          }));
                                                },
                                          betCardList[index]
                                                      .monthlyRewardsStatus ==
                                                  0
                                              ? AppColors.primaryAppbarGrey
                                              : AppColors.loginSecondaryGrad,
                                          'Received'),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    child: Row(
                                      children: [
                                        myBenefits(
                                            Assets.iconsVipwelfare5,
                                            betCardList[index]
                                                .rebateRate
                                                .toString(),
                                            Assets.iconsVipweal,
                                            '',
                                            '',
                                            'Rebate rate',
                                            'Increase income of rebate',
                                            'Received',
                                            betCardList[index]
                                                .rebateRateStatus
                                                .toString(),
                                            betCardList[index]
                                                        .rebateRateStatus ==
                                                    0
                                                ? () {}
                                                : () {},
                                            AppColors.greenButtonGrad,
                                            'Check the Details'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          //history
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppColors.unSelectedColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildInkWell(21, 'History'),
                      buildInkWell(22, 'Rules'),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                selectedIndex == 21
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.unSelectColor),
                        child: responseStatusCode == 400
                            ? const NotFoundData()
                            : vipHistory.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: vipHistory.length,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                            child: InkWell(
                                              onTap: () {},
                                              child: SizedBox(
                                                width: width,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 15, 8, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Experience Bonus',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 17,
                                                            color: Colors.blue),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      const Text(
                                                        'Betting EXP',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .dividerColor),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            vipHistory[index]
                                                                .createdAt
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .dividerColor),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            "${vipHistory[index].exp} EXP",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 15, 20, 10),
                                        child: AppBtn(
                                          title: 'View All',
                                          fontSize: 20,
                                          titleColor:
                                              AppColors.whiteColor,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AllVipHistory()));
                                          },
                                          gradient: AppColors.secondaryGradient,
                                        ),
                                      ),
                                    ],
                                  ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: AppColors.unSelectColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Center(
                                child: textWidget(
                                    text: 'VIP privileges',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor)),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Center(
                                child: textWidget(
                                    text: 'VIP rule description',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: AppColors.btnColor)),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ruleData.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 1.2),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: AppColors.unSelectColor,
                                                border: Border.all(
                                                    color: AppColors
                                                        .contLightColor,
                                                    width: 0.5),
                                                //  gradient: AppColors.unSelectedColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 30, 8, 20),
                                              child: textWidget(
                                                  text: ruleData[index]
                                                      .discription
                                                      .toString(),
                                                  fontSize: 15,
                                                  color: AppColors
                                                      .whiteColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -20,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 1),
                                            child: Container(
                                              height: height * 0.09,
                                              width: width * 0.884,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(Assets
                                                          .iconsViprulehead),
                                                      fit: BoxFit.fill)),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15.0),
                                                  child: Text(
                                                    ruleData[index]
                                                        .title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .whiteColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  myBenefits(
    String image,
    String wallet,
    String trailingIcon,
    String heart,
    String heartText,
    String title,
    String subTitle,
    String received,
    String status,
    VoidCallback? onTap,
    Gradient color,
    String onTapText,
  ) {
    return Center(
      child: SizedBox(
        height: height * 0.38,
        width: width * 0.45,
        child: Column(
          children: [
            Container(
              height: height * 0.3,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                color: AppColors.unSelectColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.2,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      gradient: AppColors.loginSecondaryGrad,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.17,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(image))),
                        ),
                        Container(
                          height: height * 0.03,
                          decoration: const BoxDecoration(
                            gradient: AppColors.loginSecondaryGrad,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                trailingIcon,
                                height: 14,
                              ),
                              textWidget(
                                text: wallet,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                                maxLines: 1,
                              ),
                              const Spacer(),
                              heart == ''
                                  ? Container()
                                  : Image.asset(
                                      heart,
                                      height: 14,
                                    ),
                              textWidget(
                                text: heartText,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: textWidget(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.whiteColor,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: textWidget(
                      text: subTitle,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dividerColor,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AppBtn(
              title: onTapText,
              fontSize: 15,
              onTap: onTap,
              hideBorder: status == '0' ? false : true,
              border: Border.all(color: Colors.white, width: 5),
              gradient: color,
              height: 40,
              width: width,
            )
          ],
        ),
      ),
    );
  }

  vipBenefit(String title, String imagePath) {
    return Container(
      alignment: Alignment.center,
      height: height * 0.03,
      width: width * 0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.whiteColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(imagePath),
              height: 16,
            ),
            textWidget(
                text: title, color: AppColors.whiteColor, fontSize: 15)
          ],
        ),
      ),
    );
  }

  addMoney(String levelId, String levelUPRewards, String monthlyRewards,
      context) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(
      Uri.parse(ApiUrl.addMoney),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "level_id": levelId,
        "level_up_rewards": levelUPRewards,
        "monthly_rewards": monthlyRewards
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == '200') {
      Navigator.pop(context);
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
      vipBetCardsData();
      return Utils.flushBarSuccessMessage(
          data['message'], context, Colors.black);
    } else if (data["status"] == "400") {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  UserViewModel userProvider = UserViewModel();

  int? responseStatusCode;
  List<VipHistoryModel> vipHistory = [];

  Future<void> vipHistoryList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
      Uri.parse('${ApiUrl.vipHistory}$token&limit=4'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        vipHistory =
            responseData.map((item) => VipHistoryModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
    } else {
      setState(() {
        vipHistory = [];
      });
      throw Exception('Failed to load transaction history');
    }
  }

  var myExp;
  var PayoutTime;
  List<VipBetCardModel> betCardList = [];
  Future<void> vipBetCardsData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    try {
      final response = await http.get(Uri.parse('${ApiUrl.vipLevel}$token'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
        final json = jsonDecode(response.body);
        myExp = json['my_exprience'];
        PayoutTime = json['days_count'];
        setState(() {
          betCardList = jsonResponse
              .map((item) => VipBetCardModel.fromJson(item))
              .toList();
          myExp;
          PayoutTime;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      rethrow;
    }
  }

  topContainer(String title, String title1, String subTitle, titleColor,
      FontWeight fontWeight) {
    return Container(
      height: height * 0.08,
      width: width * 0.45,
      decoration: BoxDecoration(
          color: AppColors.unSelectColor,
          borderRadius: BorderRadiusDirectional.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                  text: title,
                  fontSize: 15,
                  fontWeight: fontWeight,
                  color: titleColor),
              textWidget(
                  text: title1,
                  fontSize: 14,
                  //fontWeight: FontWeight.w900, // Example use of FontWeight.w900
                  color: titleColor),
            ],
          ),
          textWidget(
              text: subTitle,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.whiteColor),
        ],
      ),
    );
  }

  int selectedIndex = 21;
  buildInkWell(int index, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Center(
        child: Container(
          height: height * 0.07,
          width: width * 0.477,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: index == selectedIndex
                  ? AppColors.loginSecondaryGrad
                  : AppColors.unSelectedColor),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: index == selectedIndex
                      ? AppColors.whiteColor
                      : AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }

  popUp(String image, String title, VoidCallback onTap) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: height * 0.4,
        width: width * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppColors.loginSecondaryGrad,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.18,
              width: width * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill)),
            ),
            textWidget(text: title, fontSize: 15, fontWeight: FontWeight.w700),
            AppBtn(
              onTap: onTap,
              gradient: AppColors.primaryGradient,
              title: 'Received',
            )
          ],
        ),
      ),
    );
  }
}

class VipRule {
  final String discription;
  final String title;

  VipRule({
    required this.discription,
    required this.title,
  });
}

class VipLevel {
  final String bgImage;
  final String title;
  final String achievedImg;
  final String levelImage;
  final String targetNumber;
  final String? achievedNumber;
  final String? completePercentage;
  final Color? bottomColor;
  final Color? backGroundColor;
  final String? status;
  final String? topImg;
  final String? id;

  VipLevel({
    required this.bgImage,
    required this.title,
    required this.achievedImg,
    required this.levelImage,
    required this.targetNumber,
    required this.achievedNumber,
    required this.completePercentage,
    required this.bottomColor,
    required this.backGroundColor,
    required this.status,
    required this.topImg,
    this.id,
  });
}
