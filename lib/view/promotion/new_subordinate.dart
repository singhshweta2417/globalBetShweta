import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/new_subordinate_model.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/helper/api_helper.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

class NewSubordinate extends StatefulWidget {
  const NewSubordinate({super.key});

  @override
  State<NewSubordinate> createState() => _NewSubordinateState();
}

class _NewSubordinateState extends State<NewSubordinate> {
  @override
  void initState() {
    newSubordinate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'New Subordinate', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.unSelectedColor),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: height * 0.07,
            decoration: const BoxDecoration(
              gradient: AppColors.unSelectedColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildInkWell(1, 'Today'),
                  buildInkWell(2, 'Yesterday'),
                  buildInkWell(3, 'This Month'),
                ],
              ),
            ),
          ),
          responseStatuscode == 400
              ? const Notfounddata()
              : itemsSubordinate.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: AppColors.unSelectedColor,
                            ),
                            child: Column(
                              //  shrinkWrap: true,
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: itemsSubordinate.length,
                                  itemBuilder: (context, index) {
                                    final data = itemsSubordinate[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              textWidget(
                                                text: obscureCenterDigits(
                                                    data.mobile.toString()),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: AppColors.whiteColor,
                                              ),
                                              textWidget(
                                                text: 'UID: ${data.userName}',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: AppColors.whiteColor,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              textWidget(
                                                text: 'Direct Subordinate',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: AppColors.whiteColor,
                                              ),
                                              textWidget(
                                                text: data.datetime.toString(),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: AppColors.btnColor,
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Center(
                                  child: textWidget(
                                    text: 'No more',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: AppColors.btnColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        ],
      ),
    );
  }

  ///condition for obscure text
  String obscureCenterDigits(String input) {
    if (input.length < 4) {
      return input;
    }

    int length = input.length;

    int startIndex = (length ~/ 2) - 1;

    int endIndex = (length ~/ 2) + 1;

    List<String> chars = input.split('');

    for (int i = startIndex; i <= endIndex; i++) {
      chars[i] = '*';
    }

    return chars.join('');
  }

  int selectedIndex = 1;

  InkWell buildInkWell(int index, String text) {
    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        newSubordinate();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Center(
              child: textWidget(
                text: text,
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          const Spacer(),
          isSelected
              ? Container(
                  height: 3,
                  width: width * 0.3,
                  color: isSelected ? Colors.blue : AppColors.whiteColor,
                )
              : Container()
        ],
      ),
    );
  }

  UserViewModel userProvider = UserViewModel();

  BaseApiHelper baseApiHelper = BaseApiHelper();
  int? responseStatuscode;
  List<NewSubordinateModel> itemsSubordinate = [];
  Future<void> newSubordinate() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse('${ApiUrl.newSubordinateTabApi}$token&type=$selectedIndex'),
    );
    if (kDebugMode) {
      print('${ApiUrl.newSubordinateTabApi}$token&type=$selectedIndex');
      print('newSubordinateApi+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        itemsSubordinate = responseData
            .map((item) => NewSubordinateModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        itemsSubordinate = [];
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
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}
