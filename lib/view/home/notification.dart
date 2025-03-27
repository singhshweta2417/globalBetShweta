import 'dart:convert';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/notification_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    notify();
    // TODO: implement initState
    super.initState();
  }

  int? responseStatusCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: 'Notification',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.whiteColor,
            ),
            gradient: AppColors.unSelectedColor),
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 10),
            responseStatusCode == 400
                ? const NotFoundData()
                : items.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: AppColors.unSelectedColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Assets.iconsProNotification,
                                          scale: 1.5,
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        textWidget(
                                            text: items[index].name.toString(),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.whiteColor),
                                        const Spacer(),
                                        Image.asset(
                                          Assets.iconsDelete,
                                          scale: 1.5,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: HtmlWidget(
                                        items[index].disc.toString(),
                                        textStyle: const TextStyle(
                                            color: AppColors.greyColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
            const SizedBox(height: 20),
          ],
        ));
  }

  List<NotificationModel> items = [];

  Future<void> notify() async {
    final response = await http.get(
      Uri.parse(ApiUrl.notificationApi),
    );
    if (kDebugMode) {
      print(ApiUrl.notificationApi);
      print('notify');
    }

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData
            .map((item) => NotificationModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

class NotFoundData extends StatelessWidget {
  const NotFoundData({super.key});

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: widths / 2,
        ),
        SizedBox(height: heights * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}
