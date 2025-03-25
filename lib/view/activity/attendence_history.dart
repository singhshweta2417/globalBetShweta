import 'dart:convert';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/attendance_model.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import '../../res/components/text_widget.dart';
import 'package:http/http.dart' as http;

import '../account/all_bet_history/avaitor_all_bet_history.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  @override
  void initState() {
    attendanceHistory();
    // TODO: implement initState
    super.initState();
  }

  int? responseStatusCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          centerTitle: true,
          title: textWidget(
              text: 'Attendance history', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          gradient: AppColors.unSelectedColor),
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: AppColors.bgGrad
        ),
        child: ListView(
          children: [
            responseStatusCode == 400
                ? const Notfounddata()
                : attendanceItems.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: attendanceItems.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    gradient: AppColors.unSelectedColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        Assets.imagesCoingifts,
                                        height: 55,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          textWidget(
                                              text:
                                                  "₹${attendanceItems[index].attendanceBonus}",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                          textWidget(
                                              text:
                                                  "${attendanceItems[index].id} day",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ],
                                      ),
                                      textWidget(
                                          text: attendanceItems[index]
                                              .createdAt
                                              .toString(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.whiteColor),
                                    ],
                                  ),
                                ),
                              );
                            })),
          ],
        ),
      ),
    );
  }

  UserViewModel userProvider = UserViewModel();

  List<AttendanceModel> attendanceItems = [];

  Future<void> attendanceHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.attendanceHistory + token),
    );
    if (kDebugMode) {
      print(ApiUrl.attendanceHistory + token);
      print('attendanceHistory');
    }

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        attendanceItems =
            responseData.map((item) => AttendanceModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        attendanceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
