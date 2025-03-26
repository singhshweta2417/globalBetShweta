import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/app_constant.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/account/aboutus.dart';
import 'package:globalbet/view/account/service_center/customer_service.dart';
import 'package:globalbet/view/home/notification.dart';

class HomePageBottom extends StatefulWidget {
  const HomePageBottom({super.key});

  @override
  State<HomePageBottom> createState() => _HomePageBottomState();
}

class _HomePageBottomState extends State<HomePageBottom> {



  @override
  Widget build(BuildContext context) {
    final userData =  Provider.of<ProfileViewModel>(context);

    launchURL2() async {
      var url = userData.appLink.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    List<ProInfoModel> getProInfoList(BuildContext context) {
      return [
        ProInfoModel(
          image: Assets.iconsNotification,
          title: 'Notification',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
        ),
        ProInfoModel(
          image: Assets.iconsCusService,
          title: '24/7 Customer Service',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerCareService(),
              ),
            );
          },
        ),
        ProInfoModel(
          image: Assets.iconsAboutus,
          title: 'About us',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Aboutus(),
              ),
            );
          },
        ),
        if (kIsWeb)
          ProInfoModel(
            image: Assets.iconsDownloadButton,
            title: 'Download APP',
            onTap: () {
              launchURL2();
            },
          ),
      ];
    }
    final proInfoList = getProInfoList(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.06,
                width: width * 0.15,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.imagesAppBarSecond),
                    fit: BoxFit.fill,
                    )),
              ),
              Container(
                height: height * 0.06,
                width: width * 0.12,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.iconsEighteenplus,
                        ),
                        fit: BoxFit.fill)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          instruction(
              'The ${AppConstants.appName} platform advocates fairness, justice, and openness. We mainly operate fair lottery, blockchain games, live casinos, and slot machine games.'),
          instruction(
              "${AppConstants.appName} works with more than 10'000 online live game dealers and slot games, all of which are verified fair games."),
          instruction(
              "${AppConstants.appName} supports fast deposit and withdrawal, and looks forward to your visit."),
          SizedBox(
            width: width * 0.8,
            child: textWidget(
                text: 'Gambling can be addictive, please play rationally.',
                fontSize: 11,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            width: width * 0.8,
            child: textWidget(
                text:
                '${AppConstants.appName} only accepts customers above the age of 18.',
                fontSize: 11,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
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

          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget instruction(String title) {
    return ListTile(
      leading: Transform.rotate(
        angle: 45 * 3.1415927 / 180,
        child: Container(
          height: 10,
          width: 10,
          color: AppColors.unSelectColor,
        ),
      ),
      title: textWidget(
          text: title, fontSize: 10, color: AppColors.whiteColor),
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
