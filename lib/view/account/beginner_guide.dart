
import 'dart:convert';

import 'package:game_on/main.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/helper/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

class BeginnersGuideScreen extends StatefulWidget {
  const BeginnersGuideScreen({super.key});

  @override
  State<BeginnersGuideScreen> createState() => _BeginnersGuideScreenState();
}

class _BeginnersGuideScreenState extends State<BeginnersGuideScreen> {
  @override
  void initState() {
    fetchBeginnerData();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.darkColor,
            appBar: GradientAppBar(
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.white,
                      )),
                ),
                centerTitle: true,
                title: textWidget(
                  text: 'Beginners Guide',
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: AppColors.whiteColor,
                ),
                gradient: AppColors.unSelectedColor),
            body: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget(
                      description.toString(),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
            )));
  }

  dynamic description;
  fetchBeginnerData() async {
    final response = await http.get(
      Uri.parse("${ApiUrl.aboutus}type=3"),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'][0];
      setState(() {
        description = responseData["description"].toString();
      });
    } else {}
  }
}
