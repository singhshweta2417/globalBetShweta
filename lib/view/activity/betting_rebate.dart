import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/betting_rebate_model.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:game_on/res/view_model/user_view_model.dart';

import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class BettingRebates extends StatefulWidget {
  const BettingRebates({super.key});

  @override
  State<BettingRebates> createState() => _BettingRebatesState();
}

class _BettingRebatesState extends State<BettingRebates> {
  @override
  void initState() {
    bettingRebateList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Rebate',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w700),
          leading: const AppBackBtn(),
          centerTitle: true,
          ),
      body: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
        decoration: const BoxDecoration(
          gradient: AppColors.bgGrad
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                gradient: AppColors.unSelectedColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: 'All-Total betting rebate',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.5, color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Image(
                              image: AssetImage(
                            Assets.iconsRebateVector,
                          ),color: AppColors.whiteColor),
                          textWidget(
                              text: 'Real-time count',
                              fontSize: 12,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: height * 0.05,
                      width: width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Image(
                              image: AssetImage(
                            Assets.iconsRebatewallet,
                          ),color: AppColors.whiteColor),
                          textWidget(
                              text: totalamount == null
                                  ? "0"
                                  : totalamount.toString(),
                              fontSize: 20,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w900),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        color: AppColors.darkColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: textWidget(
                            text: 'Upgrade VIP level to increase rebate rate',
                            fontSize: 12,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.1,
                          width: width * 0.42,
                          decoration: BoxDecoration(
                            color: AppColors.unSelectColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: 'Today rebate',
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w900),
                                textWidget(
                                    text: todayRebate == null
                                        ? "0"
                                        : todayRebate.toString(),
                                    fontSize: 18,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w900),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.42,
                          decoration: BoxDecoration(
                            color: AppColors.unSelectColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: 'Total rebate',
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w900),
                                textWidget(
                                    text: totalRebate == null
                                        ? "0"
                                        : totalRebate.toString(),
                                    fontSize: 18,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w900),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    textWidget(
                        text:
                            'Automatic code washing at 01:00:00 every morning',
                        fontSize: 12,
                        color: AppColors.dividerColor,
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 10,
                    ),
                    // AppBtn(
                    //     title: 'One-Click Rebate',
                    //     fontSize: 20,
                    //     onTap: () {},
                    //     hideBorder: true,
                    //     gradient: AppColors.primaryGradient
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    height: height * 0.05,
                    width: width * 0.05,
                    child: const VerticalDivider(
                      thickness: 5,
                      color: AppColors.whiteColor,
                    )),
                const Text(
                  "  Rebate history",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rebateList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          gradient: AppColors.unSelectedColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: 'Lottery',
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      textWidget(
                                          text: rebateList[index]
                                              .datetime
                                              .toString(),
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300),
                                    ],
                                  ),
                                  textWidget(
                                      text: 'Completed',
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: AppColors.whiteColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * 0.12,
                                    width: width * 0.035,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              Assets.iconsRebatezs,
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: width * 0.82,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textWidget(
                                                text: 'Betting rebate',
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                            textWidget(
                                                text: rebateList[index]
                                                    .bettingRebate
                                                    .toString(),
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.028,
                                      ),
                                      SizedBox(
                                        width: width * 0.82,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textWidget(
                                                text: 'Rebate rate',
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                            textWidget(
                                                text:
                                                    "${rebateList[index].rebateRate}%",
                                                fontSize: 12,
                                                color: AppColors.whiteColor,
                                                fontWeight: FontWeight.w700),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.025,
                                      ),
                                      SizedBox(
                                        width: width * 0.82,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textWidget(
                                                text: 'Rebate amount',
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                            textWidget(
                                                text: rebateList[index]
                                                    .rebateAmount
                                                    .toStringAsFixed(2),
                                                fontSize: 12,
                                                color: AppColors.whiteColor,
                                                fontWeight: FontWeight.w700),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  int? responseStatusCode;

  UserViewModel userProvider = UserViewModel();

  List<BettingRebateModel> rebateList = [];
  String? dataRead;
  dynamic totalRebate;
  dynamic totalamount;
  dynamic todayRebate;

  Future<void> bettingRebateList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse('${ApiUrl.bettingRebateApi}$token&subtypeid=25'),
    );
    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data1'];
      setState(() {
        totalRebate = json
            .decode(response.body)['data'][0]['total_rebet']
            .toStringAsFixed(2);
        totalamount = json
            .decode(response.body)['data'][0]['total_amount']
            .toStringAsFixed(2);
        todayRebate = json
            .decode(response.body)['data'][0]['today_rebet']
            .toStringAsFixed(2);
        rebateList = responseData
            .map((item) => BettingRebateModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        rebateList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
