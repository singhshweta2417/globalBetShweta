import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/slider_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/account/gifts.dart';
import 'package:globalbet/view/activity/invitation_bonus.dart';
import 'package:globalbet/view/activity/activity_award.dart';
import 'package:globalbet/view/activity/activity_details.dart';
import 'package:globalbet/view/activity/attendance_bonus.dart';
import 'package:globalbet/view/activity/betting_rebate.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    activitySliderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'text': 'Activity Award',
        'icon': Assets.iconsActivityIcon1,
        'gradient': AppColors.unSelectedColor,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ActivityAward()));
        },
      },
      {
        'text': 'Invitation bonus',
        'icon': Assets.iconsActivityIcon2,
        'gradient': AppColors.unSelectedColor,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InvitationBonus()));
        },
      },
      {
        'text': 'Betting rebate',
        'icon': Assets.iconsActivityIcon3,
        'gradient': AppColors.unSelectedColor,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BettingRebates()));
        },
      },
    ];
    return Scaffold(
      appBar: GradientAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(
                text: 'Global Bet',
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: AppColors.whiteColor),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        padding:
            EdgeInsets.fromLTRB(width * 0.02, height * 0.02, width * 0.02, 0),
        decoration: const BoxDecoration(gradient: AppColors.bgGrad),
        child: ListView(
          shrinkWrap: true,
          children: [
            textWidget(
                text: 'Activity',
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: AppColors.whiteColor),
            textWidget(
                text:
                    'Please remember to follow the event page\nWe will launch user feedback activities from time to time',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColors.whiteColor),
            const SizedBox(height: 9),
            SizedBox(
              height: height * 0.15,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                itemCount: items.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        if (items[index]['onTap'] != null) {
                          items[index]['onTap']();
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.08,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: items[index]['gradient']),
                            child: Center(
                              child: Image.asset(
                                items[index]['icon'],
                                color: AppColors.whiteColor,
                                scale: 1.8,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            items[index]['text'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 10,
                                color: AppColors.dividerColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                redeemWidget(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GiftsPage()));
                }, Assets.imagesGiftRedeem, 'Gifts',
                    'Enter the redemption code to receive gift rewards'),
                redeemWidget(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendenceBonus()));
                }, Assets.imagesSignInBanner, 'Attendance bonus',
                    'The more consecutive days you sign in, the higher the reward will be.'),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: sliderData.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivityDetails(
                                bannerdata: sliderData[index])));
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    margin: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                    decoration: BoxDecoration(
                        color: AppColors.unSelectColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  sliderData[index].image.toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          '  ${sliderData[index].name.toString()}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  int? responseStatusCode;
  List<SliderModel> sliderData = [];

  Future<void> activitySliderList() async {
    final response = await http.get(
      Uri.parse(ApiUrl.banner),
    );
    setState(() {
      responseStatusCode = response.statusCode;
    });
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        sliderData =
            responseData.map((item) => SliderModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        sliderData = [];
      });
      throw Exception('Failed to load data');
    }
  }

  Widget redeemWidget(
      Function()? onTap, String image, String title, String subTitle) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppColors.unSelectedColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.17,
              width: width * 0.45,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: textWidget(
                  text: title,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: width * 0.4,
                child: textWidget(
                    text: subTitle,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
