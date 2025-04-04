import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/app_constant.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/helper/api_helper.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/view/account/service_center/customer_service.dart';
import 'package:game_on/view/home/lottery/wingo/res/size_const.dart';
import 'package:game_on/view/home/notification.dart';
import 'package:game_on/view/home/widgets/category_elements.dart';
import 'package:game_on/view/home/widgets/category_widgets.dart';
import 'package:game_on/view/home/widgets/slider_widget.dart';
import 'package:game_on/view/home/widgets/winning_information.dart';
import 'package:game_on/view/wallet/deposit_screen.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    versionCheck();
    invitationRuleApi();
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;
  bool versionView = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileViewModel>(context);

    launchURL2() async {
      var url = userData.appLink.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (kIsWeb) {
    } else {
      Future.delayed(const Duration(seconds: 3), () => showAlert(context));
    }

    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(
                  text: 'Game On',
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: AppColors.whiteColor),
            ],
          ),
        ),
        actions: [
          kIsWeb == true
              ? Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        launchURL2();
                      },
                      icon: const Icon(Icons.download_for_offline,
                          color: AppColors.goldenColor),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DepositScreen()));
                      },
                      child: Container(
                        width: width * 0.12,
                        height: height * 0.03,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.goldenColor),
                        child: const Center(
                            child: Text(
                          "Deposit",
                          style: TextStyle(
                              color: Color(0xff374992),
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen()));
                        },
                        child: Image.asset(
                          Assets.iconsProNotification,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationScreen()));
                    },
                    child: Image.asset(
                      Assets.iconsProNotification,
                      height: 30,
                      color: AppColors.primaryContColor,
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: DraggableFab(
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerCareService()));
            },
            child: Image.asset(
              Assets.iconsIconSevice,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGrad),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SliderWidget(),
            Container(
              height: height * 0.075,
              decoration: BoxDecoration(
                  gradient: AppColors.unSelectedColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    Assets.iconsMicphone,
                    height: 30,
                    color: AppColors.primaryContColor,
                  ),
                  SizedBox(width: width * 0.01),
                  _rotate(),
                ],
              ),
            ),
            Sizes.spaceHeight10,
            CategoryWidget(
              onCategorySelected: (index) {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
            CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
            const WinningInformation(),
          ],
        ),
      ),
    );
  }

  Widget _rotate() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DefaultTextStyle(
            style: const TextStyle(fontSize: 12, color: Colors.white),
            child: SizedBox(
              width: width * 0.75,
              child: AnimatedTextKit(
                repeatForever: true,
                isRepeatingAnimation: true,
                animatedTexts: invitationRuleList.isEmpty
                    ? [RotateAnimatedText("")]
                    : invitationRuleList
                        .map((rule) => RotateAnimatedText(rule))
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void showAlert(BuildContext context) {
    versionView == true
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  content: SizedBox(
                    height: 155,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 0.50,
                          height: height * 0.15,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.imagesAppBarSecond),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const Text('new version are available',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text(
                            'Update your app  ${AppConstants.appVersion}  to  $map',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _launchURL();
                          if (kDebugMode) {
                            print(versionlink);
                            print("versionlink");
                          }
                        },
                        child: const Text("UPDATE"))
                  ],
                ))
        : Container();
  }

  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.allRules}5'),
    );
    if (kDebugMode) {
      print('${ApiUrl.allRules}5');
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

  dynamic map;
  dynamic versionlink;

  Future<void> versionCheck() async {
    Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);
    final response = await http.get(
      Uri.parse(ApiUrl.versionLink),
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['version'] != AppConstants.appVersion) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          versionView = true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }

  _launchURL() async {
    var uri = Uri.parse(versionlink.toString());

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
