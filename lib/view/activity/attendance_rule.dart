import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/attendance_model.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

import '../../res/api_urls.dart';

class AttendanceRule extends StatefulWidget {
  const AttendanceRule({super.key});

  @override
  State<AttendanceRule> createState() => _AttendanceRuleState();
}

class _AttendanceRuleState extends State<AttendanceRule> {
  @override
  void initState() {
    attendenceList();
    invitationRuleApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        leading: AppBackBtn(),
        title: Text(
          'Game Rules',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: AppColors.whiteColor),
        ),
        centerTitle: true,
        gradient: AppColors.unSelectedColor,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGrad),
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: AppColors.unSelectedColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      height: height * 0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildContainer('Continuous Attendance'),
                          buildContainer('Accumulated\n    Amount'),
                          buildContainer('Attendance\n    Bonus'),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: attendenceItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = attendenceItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildContainer('${data.id} '),
                                    buildContainer(
                                        '🪙${data.accumulatedAmount}'),
                                    buildContainer('🪙${data.attendanceBonus}'),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.whiteColor,
                                  thickness: 1,
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.unSelectColor,
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.06,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: invitationRuleList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return instruction(invitationRuleList[index]);
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.06,
                    width: width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.iconsRulehead),
                            fit: BoxFit.fill)),
                    child: const Center(
                      child: Text(
                        'Rules',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  instruction(String title) {
    return ListTile(
      leading: Transform.rotate(
        angle: 45 * 3.1415927 / 180,
        child: Container(
          height: 10,
          width: 10,
          color: AppColors.whiteColor,
        ),
      ),
      title: textWidget(text: title, fontSize: 14, color: AppColors.whiteColor),
    );
  }

  buildContainer(String text) {
    return SizedBox(
      width: width * 0.28,
      //  color: Colors.black,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.whiteColor),
        ),
      ),
    );
  }

  int? responseStatuscode;
  UserViewModel userProvider = UserViewModel();

  List<AttendanceModel> attendenceItems = [];

  Future<void> attendenceList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.attendanceList + token),
    );
    if (kDebugMode) {
      print(ApiUrl.attendanceList + token);
      print('attendanceList');
    }
    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        attendenceItems =
            responseData.map((item) => AttendanceModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        attendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.allRules}4'),
    );
    if (kDebugMode) {
      print('${ApiUrl.allRules}4');
      print('allRules');
    }

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        invitationRuleList =
            json.decode(responseData[0]['list']).cast<String>();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        invitationRuleList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
