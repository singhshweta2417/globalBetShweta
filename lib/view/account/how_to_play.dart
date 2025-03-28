import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';

class HowToPlay extends StatefulWidget {
  final String type;
  const HowToPlay({super.key, required this.type});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  @override
  void initState() {
    invitationRuleApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      content: SizedBox(
        height: height * 0.55,
        child: Column(
          children: [
            Container(
              height: 40,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.imagesHowtoplayheader),
                      fit: BoxFit.fill)),
              child: Center(
                  child: textWidget(
                      text: 'How to Play',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.whiteColor)),
            ),
            Container(
              height:responseStatuscode == 400? height * 0.1:height * 0.4,
              width: width,
              color: AppColors.darkColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child:  responseStatuscode == 400
                      ? const HtmlWidget(
                    '''
                  <div style="color: white; text-align: center;">
                    <p>No data found.</p>
                  </div>
                  ''',
                  )
                      : description == null
                      ? const Center(child: CircularProgressIndicator())
                      : HtmlWidget(description.toString(),textStyle: const TextStyle(color: Colors.white),),
                ),),
            ),

            Container(
              height: height * 0.085,
              decoration: const BoxDecoration(
                color: AppColors.darkColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 15),
                child: AppBtn(
                    title: 'Close',
                    fontSize: 15,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    hideBorder: true,
                    gradient: AppColors.loginSecondaryGrad),
              ),
            )
          ],
        ),
      ),
    );
  }

  int? responseStatuscode;

  dynamic description;
  invitationRuleApi() async {
    final type = widget.type.toString();
    final response = await http.get(
      Uri.parse("${ApiUrl.aboutus}type=$type"),

    );
    setState(() {
      responseStatuscode=response.statusCode;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'][0];
      setState(() {
        description = responseData["description"].toString();
      });
    }
    else {
      if (kDebugMode) {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    }
  }
}
