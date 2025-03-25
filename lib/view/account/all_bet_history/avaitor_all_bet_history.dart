import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:http/http.dart'as http;
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/account/all_bet_history/avaitor_all_bet_history_model.dart';

class AvaitorAllHistory extends StatefulWidget {
  final String gameid;
  const AvaitorAllHistory({super.key,required this.gameid});

  @override
  State<AvaitorAllHistory> createState() => _AvaitorAllHistoryState();
}
class _AvaitorAllHistoryState extends State<AvaitorAllHistory> {


  @override
  void initState() {
    BettingHistory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //shrinkWrap: true,
      children: [
        responseStatuscode == 400
            ? const Notfounddata()
            : items.isEmpty
            ? const Center(child: CircularProgressIndicator()):
        ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: 10),
          physics:
          const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {

            if (items[index].number ==
                1) {
            } else if (items[index]
                .number ==
                2) {
            }
            else {
            }



            return ExpansionTile(
              leading: Container(
                  height: height * 0.06,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      // color: Colors.grey

                     ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      items[index].status==2?Assets.aviatorFanAviator:Assets.aviatorAviator
                    ),
                  )
              ),
              title:  Text(
                items[index].gameSrNum.toString(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              subtitle:  Text(
                  items[index].createdAt.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey)),
              trailing: Column(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 0.042,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            10),
                        border: Border.all(
                            color: items[index].status==0? AppColors.whiteColor:items[index].status==2?
                            AppColors
                                .whiteColor: Colors.green)),
                    child: Center(
                      child:  Text(
                        items[index].status==2?'Failed':items[index].status==0?'Pending':'Succeed',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            items[index].status==0?Colors.white:
                            items[index].status==2?
                            AppColors
                                .whiteColor: Colors.green),
                      ),
                    ),
                  ),
                  Text(
                    items[index].status==0?'--':
                    items[index].status==2?'- ₹${items[index].amount.toStringAsFixed(2)}':'+ ₹${items[index].win.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w700,
                        color: items[index].status==0?Colors.white:items[index].status==2?
                        AppColors
                            .whiteColor: Colors.green),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                          alignment:
                          Alignment.topLeft,
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .w900,
                                color:
                                Colors.white),
                          )),
                      const SizedBox(height: 8.0),

                      historyDetails(
                          'Period',
                          items[index].gameSrNum.toString(),
                          Colors.white),
                      historyDetails(
                          'Purchase amount',
                          items[index].amount.toString(),
                          Colors.white),

                      historyDetails('Tax',
                          items[index].commission.toString(), Colors.white),
                      historyDetails(
                          'Crash point',
                          items[index].crashPoint==null? '--': '${items[index].crashPoint} X ',

                          items[index].crashPoint==null?Colors.white:Colors.green
                      ),
                      historyDetails('Cashout amount',
                          items[index].cashoutAmount.toString(),
                          Colors.white
                      ),
                      historyDetails('Multiplayer',
                          '${items[index].multiplier} X',
                          Colors.white
                      ),
                      historyDetails('Status',
                          items[index].status==0?'Unpaid':
                          items[index].status==2?
                          'Failed':'Succeed', items[index].status==0?Colors.white:items[index].status==2?Colors.red:Colors.green),
                      historyDetails('Win/Loss',
                          items[index].status==0?'--': '₹${items[index].win.toStringAsFixed(2)}', items[index].status==0?Colors.white:items[index].status==2? Colors.red:Colors.green),
                      historyDetails(
                          'Order time',
                          items[index].createdAt.toString(),
                          Colors.white),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                setState(() {
                  pageNumber--;
                  limitResult = limitResult - 10;
                  offsetResult = offsetResult - 10;
                });
                setState(() {});
                BettingHistory();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.loginSecondaryGrad,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber/${items.length}',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  limitResult = limitResult + 10;
                  offsetResult = offsetResult + 10;
                  pageNumber++;
                });
                setState(() {});
                BettingHistory();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.loginSecondaryGrad,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
  int limitResult = 0;
  int pageNumber = 1;
  historyDetails(String title, String subtitle, Color subColor) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.unSelectColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: subColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  historyWinDetails(String title, String subtitle, String subtitle1,
      Color subColor, Color subColor1) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.unSelectColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: subColor),
                    ),
                    Text(
                      subtitle1,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: subColor1),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  int? responseStatuscode;
  UserViewModel userProvider = UserViewModel();

  int offsetResult = 0;
  List<AvaitorHistoryModel> items = [];
  Future<void> BettingHistory() async {

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
     // Uri.parse('${ApiUrl.aviatorBetHistory}$token&game_id=1'
      Uri.parse('${ApiUrl.aviatorBetHistory}$token&game_id=${widget.gameid}&limit=10&offset=0'

      ),
    );
    if (kDebugMode) {
      print('${ApiUrl.aviatorBetHistory}$token&game_id=${widget.gameid}&limit=10&offset=0');

    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => AvaitorHistoryModel.fromJson(item)).toList();

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