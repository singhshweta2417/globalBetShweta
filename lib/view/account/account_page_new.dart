// ignore_for_file: use_build_context_synchronously

import 'package:globalbet/res/app_constant.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/account/all_bet_history/all_bet_history.dart';
import 'package:globalbet/view/account/beginnerguide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/clipboard.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/res/provider/profile_provider.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:globalbet/view/account/aboutus.dart';
import 'package:globalbet/view/account/logout.dart';
import 'package:globalbet/view/account/service_center/custmor_service.dart';
import 'package:globalbet/view/account/service_center/setting_page_new.dart';
import 'package:globalbet/view/account/transction_history.dart';
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


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();
  @override
  Widget build(BuildContext context) {
    final userData = context.read<ProfileProvider>();
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
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BeginnersGuideScreen()));
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
          }),
      ProInfoModel(
          image: Assets.iconsGift,
          title: 'Gifts',
          onTap: () {
            Navigator.pushNamed(context, RoutesName.giftsscreen);
          }),

    ];

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      body:
      ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                      height: height * 0.39,
                      width: width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.imagesHeadbg,),fit: BoxFit.fill),
                        ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 55, 10, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(context.watch<ProfileProvider>().userImage.toString()),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    textWidget(
                                        text:
                                        context.read<ProfileProvider>().userName.toString().toUpperCase(),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primaryTextColor),
                                    SizedBox(width: width*0.02,),
                                    Image.asset(Assets.iconsProfilevip1,scale: 1.7,),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.percentageColor,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        textWidget(
                                            text: 'UID',
                                            color: AppColors.primaryTextColor,
                                            fontSize: 16),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 2,
                                          height: 18,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        textWidget(
                                            text:
                                            userData.uId.toString(),
                                            color: AppColors.primaryTextColor,
                                            fontSize: 16),
                                        const SizedBox(width: 8),
                                        InkWell(
                                            onTap: () {
                                              copyToClipboard(
                                                  userData.uId.toString(), context);
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
                                    text:'Last Login: ${userData.lastLoginTime}',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.primaryTextColor),
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.3, left: width * 0.025),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.25,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                          gradient: AppColors.primaryUnselectedGradient,
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: 'Total Balance',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.primaryTextColor),
                            Row(
                              children: [
                                const Icon(Icons.currency_rupee,
                                    size: 25,
                                    color: AppColors.primaryTextColor),
                                textWidget(
                                    text:
                                    userData.totalWallet==null?'0':
                                    userData.totalWallet.toStringAsFixed(2),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: AppColors.primaryTextColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      context.read<ProfileProvider>().fetchProfileData();
                                      Utils.flushBarSuccessMessage('Wallet refresh ✔', context, Colors.white);
                                    },
                                    child: Image.asset(
                                      Assets.iconsTotalBal,
                                      color: AppColors.primaryTextColor,
                                      scale: 2,
                                    )),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildInkWell(
                                    Assets.iconsWalletnew, 'Wallet', () {
                                  NavigatorService.navigateToScreenThree(context);
                                }),
                                buildInkWell(
                                    Assets.iconsProDeposit, 'Deposit', () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositScreen()));
                                }),
                                buildInkWell(
                                    Assets.iconsProWithdraw, 'Withdraw', () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawScreen()));
                                }),
                                // buildInkWell(Assets.iconsProVip, 'VIP', () {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const VipScreenNew()));
                                //
                                // }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: height * 0.03,
                    // ),
                    // Container(
                    //   height: height * 0.15,
                    //   width: width * 0.95,
                    //   decoration: BoxDecoration(
                    //       gradient: AppColors.loginSecondryGrad,
                    //       borderRadius: BorderRadiusDirectional.circular(15)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    //     child: Row(
                    //       children: [
                    //         SizedBox(
                    //           height: 50,
                    //           width: 50,
                    //           child: Image.asset(
                    //             Assets.iconsVault,
                    //             scale: 1,
                    //           ),
                    //         ),
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const SizedBox(
                    //               height: 15,
                    //             ),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 textWidget(
                    //                   text: 'Safe',
                    //                   fontWeight: FontWeight.w900,
                    //                   fontSize: 15,
                    //                   color: AppColors.primaryTextColor,
                    //                 ),
                    //                 SizedBox(
                    //                   width: width * 0.38,
                    //                 ),
                    //                 Container(
                    //                   height: 25,
                    //                   width: 70,
                    //                   decoration: BoxDecoration(
                    //                     color: AppColors.iconsColor,
                    //                     borderRadius:
                    //                         BorderRadiusDirectional.circular(
                    //                             30),
                    //                   ),
                    //                   child: Center(
                    //                     child: textWidget(
                    //                       text: '₹ 0.00',
                    //                       fontWeight: FontWeight.w900,
                    //                       fontSize: 14,
                    //                       color: AppColors.primaryTextColor,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const Icon(
                    //                   Icons.arrow_forward_ios,
                    //                   color: Colors.white,
                    //                 )
                    //               ],
                    //             ),
                    //             textWidget(
                    //               text:
                    //                   'Daily interest rate 0.1% + VIP extra income\n safe, calculated every 1 minute',
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 12,
                    //               color: AppColors.primaryTextColor,
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        historyWidget(Assets.iconsBetHistory, 'Game History',
                            'My Game History', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllBetHistory()));
                            }),
                        historyWidget(Assets.iconsTransHistory, 'Transction',
                            'My Transction\nHistory', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const TransctionHistory()));
                            }),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        historyWidget(
                            Assets.iconsRechargeHistory,
                            'Deposit        ',
                            'My Deposit\nHistory',
                            () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositHistory()));

                        }),
                        historyWidget(Assets.iconsWithdrawHistory,
                            'Withdraw   ', 'My Withdraw\nHistory', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawHistory()));

                            }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: AppColors.primaryUnselectedGradient,
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
                                    ),
                                    title: textWidget(
                                      text: proInfoList[index].title,
                                      fontSize: 18,
                                      color: AppColors.primaryTextColor,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  if (index != proInfoList.length - 1) // Render divider for all except last item
                                    const Divider(
                                      thickness: 0.5,
                                      color: AppColors.gradientFirstColor,
                                      endIndent: 20,
                                      indent: 20,
                                    ),
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: AppColors.primaryUnselectedGradient,
                            borderRadius:
                            BorderRadiusDirectional.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 15),
                              child: textWidget(
                                  text: 'Service center',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryTextColor),
                            ),
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
                                    childAspectRatio: 2.5 / 2),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: serviceList[index].onTap,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          serviceList[index].image,
                                          height: height * 0.055,
                                        ),
                                        textWidget(
                                            text: serviceList[index].title,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color:
                                            AppColors.primaryTextColor),
                                        textWidget(
                                            text:
                                            serviceList[index].subtitle ??
                                                '',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color:
                                            AppColors.primaryTextColor),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: GestureDetector(
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
                                  width: 0.5, color: AppColors.gradientFirstColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Image.asset(Assets.iconsLogOut,scale: 1.5,color: AppColors.gradientFirstColor,)),
                              textWidget(
                                  text: '  Log out',
                                  fontSize: 20,
                                  color: AppColors.gradientFirstColor)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Version : ${AppConstants.appVersion}",
                        style: TextStyle(
                          color: AppColors.whiteColor
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
        //    :const Center(child: CircularProgressIndicator())
    );

  }

  historyWidget(
      String img, String title, String subtitle, VoidCallback onTapCallback) {
    return InkWell(
      onTap: onTapCallback,
      child: Container(
        height: height * 0.12,
        width: width * 0.45,
        decoration: BoxDecoration(
            gradient: AppColors.primaryUnselectedGradient,
            borderRadius: BorderRadiusDirectional.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  img,
                  // Assets.iconsBetHistory,
                  scale: 1,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  const SizedBox(height: 15,),

                  textWidget(
                    text: title,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: AppColors.primaryTextColor,
                  ),
                  textWidget(
                    text: subtitle,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: AppColors.dividerColor,
                  ),
                ],
              ),
            ],
          ),
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
            color: AppColors.primaryTextColor,
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
