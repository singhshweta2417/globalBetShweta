import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_widget.dart';

class InvitationRules extends StatefulWidget {
  const InvitationRules({super.key});

  @override
  State<InvitationRules> createState() => _InvitationRulesState();
}
class _InvitationRulesState extends State<InvitationRules> {

  List<LevelList> itemsLevel = [
    LevelList(l1: 'L0', l2: '0', l3: '0', l4: '0'),
    LevelList(l1: 'L1', l2: '5', l3: '500k', l4: '100k'),
    LevelList(l1: 'L2', l2: '10', l3: '1,000k', l4: '200k'),
    LevelList(l1: 'L3', l2: '15', l3: '2.50M', l4: '500k'),
    LevelList(l1: 'L4', l2: '20', l3: '3.50M', l4: '700k'),
    LevelList(l1: 'L5', l2: '25', l3: '5M', l4: '1,000k'),

  ];
  List<LevelList1> itemsLevel1 = [
    LevelList1(l1: 'Only registered users can send invitations.             \nInvite friends who are 18 years or older.'),
    LevelList1(l1: 'Use the unique invitation link found in your profile.\nShare via email, social media, or direct message.'),
    LevelList1(l1: "Earn rewards for each successful referral who registers and plays.\nBoth the inviter and the invitee receive bonus coins."),
    LevelList1(l1: "Do not spam or misuse the invitation system.\nInvitations must be to genuine friends or contacts."),
    LevelList1(l1: "We monitor invitation activity.\nMisuse can result in suspension of invitation privileges."),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Invitation rules',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.unSelectedColor),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Center(
              child: textWidget(
                  text: '【Privacy Agreement】 program',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor)),
          SizedBox(
            height: height * 0.01,
          ),
          Center(
              child: textWidget(
                  text: 'This activity is valid for a long time',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.btnColor)),
          SizedBox(
            height: height * 0.02,
          ),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemsLevel1.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: index == 5
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.darkColor,
                                      border: Border.all(
                                          color:
                                          AppColors.contLightColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),

                              ],
                            ),

                            Positioned(
                              top: -12,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.96,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage(Assets.iconsRulehead2),
                                          fit: BoxFit.fill)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        '0${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: AppColors.whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.darkColor,
                                  border: Border.all(
                                      color:
                                          AppColors.contLightColor,
                                      width: 2),
                                  //  gradient: AppColors.unSelectedColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8,30,8,20),
                                child: textWidget(
                                    text:itemsLevel1[index].l1.toString(),
                                    fontSize: 15,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              top: -12,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.96,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(Assets.iconsRulehead2),
                                          fit: BoxFit.fill)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        '0${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: AppColors.whiteColor),
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
    );
  }
}

class LevelList {
  String? l1;
  String? l2;
  String? l3;
  String? l4;

  LevelList({
    this.l1,
    this.l2,
    this.l3,
    this.l4,
  });
}
class LevelList1 {
  String? l1;


  LevelList1({
    this.l1,
  });
}
