import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/invitation_bonus_model.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/helper/api_helper.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/activity/invitation_bonus_history.dart';
import 'package:globalbet/view/activity/invitation_reward_rules.dart';
import 'package:globalbet/view/home/lottery/wingo/res/size_const.dart';
import 'package:http/http.dart' as http;

class InvitationBonus extends StatefulWidget {
  const InvitationBonus({super.key});

  @override
  State<InvitationBonus> createState() => _InvitationBonusState();
}

class _InvitationBonusState extends State<InvitationBonus> {
  bool isClaimed = false;

  @override
  void initState() {
    invationbonusList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.darkColor,
      appBar: const GradientAppBar(
          leading: AppBackBtn(),
          title: Text(
            'Invitation bonus',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: AppColors.whiteColor),
          ),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: Stack(
        children: [
          Container(
            height: height * 0.35,
            width: width,
            decoration:
                const BoxDecoration(gradient: AppColors.unSelectedColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.2,
                    width: width * 0.3,
                    child: Image.asset(Assets.iconsInvitationGift),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invite friends and deposit ',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: AppColors.whiteColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Both parties can receive rewards ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.whiteColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Invite friends to register and recharge\nto receive rewards',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.whiteColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Activity date ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.whiteColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '2024-02-28-2099-02-27',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width*0.03, height*0.25,width*0.03,0),
            child: Column(
              children: [
                Container(
                  height: height * 0.18,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.contSelectColor,
                    border: Border.all(color: AppColors.unSelectColor)
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InvitationRewardRules()));
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: height * 0.1,
                                width: width * 0.2,
                                child: Image.asset(Assets.iconsInviterule),
                              ),
                              const Text('Invitation reward rules ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InvitationBonsHistory()));
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: height * 0.1,
                                width: width * 0.2,
                                child: Image.asset(Assets.iconsInviterecord),
                              ),
                              const Text('Invitation record ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Sizes.spaceHeight30,
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: invationbonus.length,
                      itemBuilder: (context, index) {
                        final data = invationbonus[index];
                        return Container(
                         margin: const EdgeInsets.only(bottom: 30),
                         padding: const EdgeInsets.all(10),
                          height: height*0.3,
                          width: width,
                          decoration:  BoxDecoration(
                            gradient: AppColors.bgGrad,border: Border.all(color: AppColors.unSelectColor)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height * 0.062,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        color: data.status == "0"
                                            ? Colors.grey
                                            : Colors.green,
                                       ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Bonus ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Colors.white)),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            child: Text(
                                                data.bonusId.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900,
                                                    fontSize: 17,
                                                    color: Colors.black)),
                                          ),
                                          const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.close,
                                                size: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text('₹${data.claimAmount}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                          color:
                                              AppColors.whiteColor))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Number of invitees ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white)),
                                  SizedBox(
                                    width: width * 0.3,
                                  ),
                                  Text(data.noOfInvitees.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          color: Colors.white)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Recharge per people ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white)),
                                  SizedBox(
                                    width: width * 0.27,
                                  ),
                                  Text(data.amount.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          color: Colors.white)),
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          '${data.noOfInvitees < data.noOfUser ? data.noOfInvitees : data.noOfUser} / ${data.noOfUser}',
                                          // 10 < 1 ? 10 : 1
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22,
                                              color: AppColors
                                                  .whiteColor)),
                                      const Text('Number of invitees',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          '${data.referInvitees < data.noOfUser ? data.referInvitees : data.noOfUser} / ${data.noOfUser}',

                                          // 4 < 1 ? 4:1
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22,
                                              color: AppColors
                                                  .whiteColor)),
                                      const Text('Deposit Numbers',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              AppBtn(
                                height: height * 0.065,
                                title: data.status == "0"
                                    ? "Claimed"
                                    : data.status == "1"
                                        ? "Not Completed"
                                        : "Claim Now",
                                fontSize: 20,
                                onTap: () {
                                  print(data.noOfInvitees);
                                  print('noofincvgh');
                                  print(data.noOfUser);
                                  print('useertghnjm');
                                  print(data.status);
                                  print("stasrtdfghgbjn");
                                  data.status == "0"
                                      ? Utils.flushBarErrorMessage(
                                          "Already Claimed",
                                          context,
                                          AppColors.red)
                                      : data.status == "1"
                                          ? Utils.flushBarSuccessMessage(
                                              "Not Completed",
                                              context,
                                              AppColors.blackColor)
                                          : bonusClaim(context,
                                              data.claimAmount, data.bonusId);
                                },
                                hideBorder: true,
                                gradient: data.status == "0"
                                    ? AppColors.redButton
                                    : data.status == "1"
                                        ? AppColors.primaryGradient
                                        : AppColors.greenButtonGrad,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  UserViewModel userProvider = UserViewModel();

  bonusClaim(context, dynamic amount, dynamic inviteId) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.bonusClaim),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "amount": amount.toString(),
        "invite_id": inviteId.toString()
      }),
    );
    if (kDebugMode) {
      print(
        Uri.parse(ApiUrl.bonusClaim),
      );
    }
    print({"userid": token, "amount": amount});
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      invationbonusList();
      return Utils.flushBarSuccessMessage(
          data['message'], context, Colors.black);
    } else if (data["status"] == 400) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  int? responseStatuscode;

  List<InvitationBonusModel> invationbonus = [];

  Future<void> invationbonusList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.invitationBonusList + token),
    );
    if (kDebugMode) {
      print(ApiUrl.invitationBonusList + token);
      print('invitationBonusList');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        invationbonus = responseData
            .map((item) => InvitationBonusModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        invationbonus = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.05,
        ),
        Image.asset(
          Assets.imagesNoDataAvailable,
          height: height * 0.21,
        ),
        // Image(
        //   image: const AssetImage(Assets.imagesNoDataAvailable),
        //   height: heights / 3,
        //   width: widths / 2,
        // ),
        const Text(
          "No data (:",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
