import 'dart:convert';
import 'package:game_on/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/view/home/mini/Aviator/aviator_model/my_bet_model.dart';


class AllBets {
  String? username;
  String? bet;
  String? win;
  AllBets(this.username, this.bet, this.win);
}

class AvaitorBetHistory extends StatefulWidget {
  const AvaitorBetHistory({Key? key}) : super(key: key);

  @override
  State<AvaitorBetHistory> createState() => _AvaitorBetHistoryState();
}

class _AvaitorBetHistoryState extends State<AvaitorBetHistory> {
  List<MyBetModel> bets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBet();
  }


  @override
  Widget build(BuildContext context) {
    if (responseStatusCode == 400) {
      return const SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 50,
              color: Colors.grey,
            ),
            Text('No Data Found Today',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bets.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(gradient: AppColors.secondaryAppbar,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(height: height*0.023),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(text: "Game S.No",
                              fontSize: width*0.03,
                              fontWeight: FontWeight.w800,
                              color: AppColors.whiteColor
                          ),
                          textWidget(text: '2024${bets[index].gameSrNum}',
                              fontSize: width*0.045,
                              fontWeight: FontWeight.w800,
                            color: AppColors.whiteColor
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(text: "Bet, INR X",
                              fontSize: width*0.03,
                              fontWeight: FontWeight.w800,
                              color: AppColors.whiteColor
                          ),
                          SizedBox(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(bets[index].multiplier=='0.0'?'${bets[index].amount}':'${bets[index].amount} , ',
                                      style:  TextStyle(
                                          color:  AppColors.whiteColor,
                                           fontSize: width*0.045,
                                      )
                                  ),
                                  Text(bets[index].multiplier=='null'?'':'${bets[index].multiplier}',
                                      style:  TextStyle(
                                          color:  AppColors.whiteColor,  fontSize: width*0.045,)),
                                ],
                              )),

                        ],
                      ),
                    ),
                    SizedBox(height: height*0.01,),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(text: "Win, INR",
                              fontSize: width*0.03,
                              fontWeight: FontWeight.w800,
                              color: AppColors.whiteColor
                          ),
                          Center(
                            child: Text(bets[index].cashoutAmount=="null"?'- 🪙 0.0':
                            '+ 🪙 ${bets[index].cashoutAmount}',
                                style:  TextStyle(
                                    color:  bets[index].cashoutAmount=="null"?Colors.red:
                                    Colors.green,
                                    fontSize: 14)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.01,),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(text: "Date & Time",
                              fontSize: width*0.03,
                              fontWeight: FontWeight.w800,
                              color: AppColors.whiteColor
                          ),
                          textWidget(
                              text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(bets[index].datetime.toString())),
                              fontSize: width*0.045,
                              fontWeight: FontWeight.w800,
                              color: AppColors.whiteColor
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.023),
                  ],
                ),
              ),
            );
          });
    }
  }

  int? responseStatusCode;
  UserViewModel userProvider = UserViewModel();

  Future<void> myBet() async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final url = "${ApiUrl.aviatorBetHistory}$userid&game_id=5";
    try {
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(url);
        print("vytdidy");
        print(url);
      }
      setState(() {
        responseStatusCode = response.statusCode;
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          bets = (responseData['data'] as List<dynamic>)
              .map((item) => MyBetModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print('Data not found');
        }
      } else {
        setState(() {
          bets = [];
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      setState(() {
        bets = [];
      });
    }
  }
}
