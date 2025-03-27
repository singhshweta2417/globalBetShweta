import 'package:globalbet/res/app_constant.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/account/all_bet_history/all_bet_history.dart';
import 'package:globalbet/view/account/beginner_guide.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/view/home/lottery/wingo/res/size_const.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/clipboard.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:globalbet/view/account/aboutus.dart';
import 'package:globalbet/view/account/logout.dart';
import 'package:globalbet/view/account/service_center/customer_service.dart';
import 'package:globalbet/view/account/service_center/setting_page_new.dart';
import 'package:globalbet/view/account/transaction_history.dart';
import 'package:globalbet/view/bottom/bottom_nav_bar.dart';
import 'package:globalbet/view/home/notification.dart';
import 'package:globalbet/view/wallet/deposit_history.dart';
import 'package:globalbet/view/wallet/deposit_screen.dart';
import 'package:globalbet/view/wallet/withdraw_screen.dart';
import 'package:globalbet/view/wallet/withdrawal_history.dart';

class AccountPageNew extends StatefulWidget {
  const AccountPageNew({super.key});

  @override
  State<AccountPageNew> createState() => _AccountPageNewState();
}

class _AccountPageNewState extends State<AccountPageNew> {
  BaseApiHelper baseApiHelper = BaseApiHelper();
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileViewModel>(context);
    List<ServiceModel> serviceList = [
      ServiceModel(
          image: Assets.iconsSetting,
          title: 'Setting',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingPageNew()));
          }),
      ServiceModel(
          image: Assets.iconsFeedback,
          title: 'Feedback',
          onTap: () {
            Navigator.pushNamed(context, RoutesName.feedbackscreen);
          }),
      ServiceModel(
          image: Assets.iconsNotification,
          title: 'Notification',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
          }),
      ServiceModel(
          image: Assets.iconsCusService,
          title: '24/7 customer',
          subtitle: "services",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerCareService()));
          }),
      ServiceModel(
          image: Assets.iconsBigGuide,
          // title: "Privacy Policy",
          title: "Beginners Guide",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BeginnersGuideScreen()));
          }),
      ServiceModel(
          image: Assets.iconsAboutus,
          title: 'About us',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Aboutus()));
          }),
    ];
    List<ProInfoModel> proInfoList = [
      ProInfoModel(
          image: Assets.iconsProNotification,
          title: 'Notification',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
          }),
      ProInfoModel(
          image: Assets.iconsGift,
          title: 'Gifts',
          onTap: () {
            Navigator.pushNamed(context, RoutesName.giftsscreen);
          }),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGrad),
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Container(
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                        color: AppColors.contLightColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                          NetworkImage(userData.userImage.toString()),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                textWidget(
                                    text: userData.userName
                                        .toString()
                                        .toUpperCase(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.whiteColor),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Image.asset(
                                  Assets.iconsProfilevip1,
                                  scale: 1.7,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: AppColors.darkColor,
                                borderRadius:
                                BorderRadiusDirectional.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    textWidget(
                                        text: 'UID',
                                        color: AppColors.whiteColor,
                                        fontSize: 16),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 2,
                                      height: 18,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    textWidget(
                                        text: userData.userId.toString(),
                                        color: AppColors.whiteColor,
                                        fontSize: 16),
                                    const SizedBox(width: 8),
                                    InkWell(
                                        onTap: () {
                                          copyToClipboard(
                                              userData.userId.toString(),
                                              context);
                                        },
                                        child: Center(
                                          child: Image.asset(
                                            Assets.iconsCopy,
                                            scale: 1.4,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            textWidget(
                                text:
                                'Last Login: ${userData.lastLoginTime}',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.whiteColor),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding:  EdgeInsets.only(top:height*0.25),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        height: height * 0.25,
                        width: width * 0.95,
                        decoration: BoxDecoration(
                            color: AppColors.contSelectColor,
                            borderRadius: BorderRadiusDirectional.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: 'Total Balance',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.whiteColor),
                            Row(
                              children: [
                                const Icon(Icons.currency_rupee,
                                    size: 25,
                                    color: AppColors.whiteColor),
                                textWidget(
                                    text: userData.balance == null
                                        ? '0'
                                        : userData.balance.toStringAsFixed(2),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: AppColors.whiteColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      userData.profileApi(context);
                                      Utils.flushBarSuccessMessage(
                                          'Wallet refresh ✔',
                                          context,
                                          Colors.white);
                                    },
                                    child: Image.asset(
                                      Assets.iconsTotalBal,
                                      color: AppColors.whiteColor,
                                      scale: 2,
                                    )),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                buildInkWell(Assets.iconsWalletnew, 'Wallet',
                                    () {
                                  NavigatorService.navigateToScreenThree(
                                      context);
                                }),
                                buildInkWell(
                                    Assets.iconsProDeposit, 'Deposit', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DepositScreen()));
                                }),
                                buildInkWell(
                                    Assets.iconsProWithdraw, 'Withdraw', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WithdrawScreen()));
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          historyWidget(Assets.iconsBetHistory, 'Game History',
                              'My Game History', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllBetHistory()));
                          }),
                          historyWidget(Assets.iconsTransHistory, 'Transction',
                              'My Transction\nHistory', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TransactionHistory()));
                          }),
                        ],
                      ),
                      Sizes.spaceHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          historyWidget(Assets.iconsRechargeHistory,
                              'Deposit        ', 'My Deposit\nHistory', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DepositHistory()));
                          }),
                          historyWidget(Assets.iconsWithdrawHistory,
                              'Withdraw   ', 'My Withdraw\nHistory', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WithdrawHistory()));
                          }),
                        ],
                      ),
                      Sizes.spaceHeight20,
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width*0.04),
                        decoration: BoxDecoration(
                            color: AppColors.contSelectColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: proInfoList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: proInfoList[index].onTap,
                                    leading: Image.asset(
                                      proInfoList[index].image,
                                      height: height * 0.055,
                                      color: AppColors.whiteColor,
                                    ),
                                    title: textWidget(
                                      text: proInfoList[index].title,
                                      fontSize: 18,
                                      color: AppColors.whiteColor,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  if (index !=
                                      proInfoList.length -
                                          1) // Render divider for all except last item
                                    const Divider(
                                      thickness: 0.5,
                                      color: AppColors.whiteColor,
                                      endIndent: 20,
                                      indent: 20,
                                    ),
                                ],
                              );
                            }),
                      ),
                      Sizes.spaceHeight20,
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width*0.04),
                        padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.01),
                        decoration: BoxDecoration(
                            color: AppColors.contSelectColor,
                            borderRadius:
                                BorderRadiusDirectional.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: 'Service center',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor),
                            Sizes.spaceHeight10,
                            GridView.builder(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: serviceList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        crossAxisCount: 3,
                                        childAspectRatio: 2 / 2),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: serviceList[index].onTap,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          serviceList[index].image,
                                          height: height * 0.055,
                                          color: AppColors.whiteColor,
                                        ),
                                        textWidget(
                                            text: serviceList[index].title,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color:
                                                AppColors.whiteColor),
                                        textWidget(
                                            text:
                                                serviceList[index].subtitle ??
                                                    '',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color:
                                                AppColors.whiteColor),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      Sizes.spaceHeight25,
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => const Logout());
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30),
                              border: Border.all(
                                  width: 0.5,
                                  color: AppColors.whiteColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Image.asset(
                                Assets.iconsLogOut,
                                scale: 1.5,
                                color: AppColors.whiteColor,
                              )),
                              textWidget(
                                  text: '  Log out',
                                  fontSize: 20,
                                  color: AppColors.whiteColor)
                            ],
                          ),
                        ),
                      ),
                      Sizes.spaceHeight20,
                      const Text(
                        "Version : ${AppConstants.appVersion}",
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                      Sizes.spaceHeight30,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  historyWidget(
      String img, String title, String subtitle, VoidCallback onTapCallback) {
    return InkWell(
      onTap: onTapCallback,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        height: height * 0.12,
        width: width * 0.45,
        decoration: BoxDecoration(
            color: AppColors.contSelectColor,
            borderRadius: BorderRadiusDirectional.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                img,
                scale: 1,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                  text: title,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  color: AppColors.whiteColor,
                ),
                textWidget(
                  text: subtitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: AppColors.greyColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///profile
  Widget buildInkWell(String img, String title, VoidCallback onTapCallback) {
    return InkWell(
      onTap: onTapCallback,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              img,
              scale: 1,
            ),
          ),
          textWidget(
            text: title,
            fontWeight: FontWeight.w900,
            fontSize: 14,
            color: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}

class ProInfoModel {
  final String image;
  final String title;
  final VoidCallback? onTap;

  ProInfoModel({
    required this.image,
    required this.title,
    this.onTap,
  });
}

class ServiceModel {
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  ServiceModel({
    required this.image,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}
