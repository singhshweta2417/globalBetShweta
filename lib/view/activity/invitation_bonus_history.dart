import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/invitation_bonus_history_model.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class InvitationBonsHistory extends StatefulWidget {
  const InvitationBonsHistory({super.key});

  @override
  State<InvitationBonsHistory> createState() => _InvitationBonsHistoryState();
}

class _InvitationBonsHistoryState extends State<InvitationBonsHistory> {
  @override
  void initState() {
    invitationRecordHistory();
    // TODO: implement initState
    super.initState();
  }

  int? responseStatuscode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: textWidget(
            text: 'Invitation record', fontSize: 25, color: Colors.white),
        leading: const AppBackBtn(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        decoration: const BoxDecoration(gradient: AppColors.bgGrad),
        child: ListView(
          children: [
            responseStatuscode == 400
                ? const Notfounddata()
                : invitationRecordItems.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: invitationRecordItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = invitationRecordItems[index];
                          return Container(
                            margin:
                                EdgeInsets.symmetric(vertical: height * 0.02),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: AppColors.unSelectedColor),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: data.username.toString(),
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      textWidget(
                                          text: 'UID: ${data.uId}',
                                          fontSize: 14,
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w800),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: 'Registration time',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      textWidget(
                                          text: data.createdAt,
                                          fontSize: 12,
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w800),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: 'Deposit amount',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      textWidget(
                                          text: '🪙${data.firstRechargeAmount}',
                                          fontSize: 15,
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
          ],
        ),
      ),
    );
  }

  UserViewModel userProvider = UserViewModel();

  List<InvitationBonusHistoryModel> invitationRecordItems = [];

  Future<void> invitationRecordHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.invitationRecords + token),
    );
    if (kDebugMode) {
      print(ApiUrl.invitationRecords + token);
      print('AttendenceList');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        invitationRecordItems = responseData
            .map((item) => InvitationBonusHistoryModel.fromJson(item))
            .toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        invitationRecordItems = [];
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
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        const Text(
          "No data (:",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
