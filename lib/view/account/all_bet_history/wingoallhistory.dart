// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:globalbet/generated/assets.dart';
// import 'package:globalbet/main.dart';
// import 'package:globalbet/model/bettingHistory_Model.dart';
// import 'package:globalbet/model/user_model.dart';
// import 'package:globalbet/res/aap_colors.dart';
// import 'package:globalbet/res/api_urls.dart';
// import 'package:globalbet/res/components/text_widget.dart';
// import 'package:globalbet/res/helper/api_helper.dart';
// import 'package:globalbet/res/provider/user_view_provider.dart';
// import 'package:http/http.dart'as http;
//
// class WingoAllHistory extends StatefulWidget {
//   const WingoAllHistory({super.key});
//
//   @override
//   State<WingoAllHistory> createState() => _WingoAllHistoryState();
// }
//
// class _WingoAllHistoryState extends State<WingoAllHistory> {
//
//   int selectedIndex = 1;
//   int limitResult = 10;
//   int offsetResult = 0;
//   int pageNumber = 1;
//   @override
//   void initState() {
//     BettingHistory();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//      // shrinkWrap: true,
//       children:  [
//
//         Container(
//           height: height*0.07,
//           color: AppColors.filledColor,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment:CrossAxisAlignment.center ,
//               children: [
//                 buildInkWell(1, 'WinGo 1 min'),
//                 buildInkWell(2, 'WinGo 3 min'),
//                 buildInkWell(3, 'WinGo 5 min'),
//                 buildInkWell(4, 'WinGo 10 min'),
//               ],
//             ),
//           ),
//         ),
//         responseStatuscode == 400
//             ? const Notfounddata()
//             : items.isEmpty
//             ? const Center(child: CircularProgressIndicator()):
//         ListView.builder(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 10),
//           physics:
//           const ScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             List<Color> colors;
//
//             if (items[index].number ==
//                 0) {
//               colors = [
//                 AppColors.orangeColor,
//                 AppColors.primaryTextColor,
//               ];
//             } else if (items[index]
//                 .number ==
//                 5) {
//               colors = [
//                 const Color(0xFF40ad72),
//                 AppColors.primaryTextColor,
//               ];
//             } else if (items[index]
//                 .number ==
//                 10) {
//               colors = [
//                 const Color(0xFF40ad72),
//                 const Color(0xFF40ad72),
//               ];
//             }
//             else if (items[index]
//                 .number ==
//                 20) {
//               colors = [
//                 AppColors.primaryTextColor,
//                 AppColors.primaryTextColor,
//               ];
//             }
//             else if (items[index]
//                 .number ==
//                 30) {
//               colors = [
//                 AppColors.orangeColor,
//                 AppColors.orangeColor,
//               ];
//             }
//
//             else if (items[index].number ==
//                 40) {
//               colors = [
//                 AppColors.goldencolor,
//                 AppColors.goldencolor,
//               ];
//             } else if (items[index]
//                 .number ==
//                 50) {
//               colors = [
//                 const Color(0xff6eb4ff),
//                 const Color(0xff6eb4ff)
//               ];
//             }
//             else {
//               int number = int.parse(
//                   items[index]
//                       .number
//                       .toString());
//               colors = number.isOdd
//                   ? [
//                 const Color(0xFF40ad72),
//                 const Color(0xFF40ad72),
//               ]
//                   : [
//                 AppColors.orangeColor,
//                 AppColors.orangeColor,
//               ];
//             }
//
//
//
//             return ExpansionTile(
//               leading: Container(
//                   height: height * 0.06,
//                   width: width * 0.12,
//                   decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(10),
//                       // color: Colors.grey
//                       gradient: LinearGradient(
//                           stops: const [
//                             0.5,
//                             0.5
//                           ],
//                           colors:colors,
//                           begin: Alignment.topLeft,
//                           end: Alignment
//                               .bottomRight)),
//                   child:  Center(
//                     child: Text(items[index]
//                         .number==40?'Big':items[index]
//                         .number==50?'Small':
//                     items[index]
//                         .number==10?'G':
//                     items[index]
//                         .number==20?'W':
//                     items[index]
//                         .number==30?'O':
//                     items[index]
//                         .number
//                         .toString(),
//                       style: TextStyle(
//                           fontSize: items[index]
//                               .number==40?10:items[index]
//                               .number==50?10:20,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.black),
//                     ),
//                   )
//               ),
//               title:  Text(
//                 items[index].gamesno.toString(),
//                 style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.white),
//               ),
//               subtitle:  Text(
//                   items[index].createdAt.toString(),
//                   style: const TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.grey)),
//               trailing: Column(
//                 mainAxisAlignment:
//                 MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     height: height * 0.042,
//                     width: width * 0.2,
//                     decoration: BoxDecoration(
//                         borderRadius:
//                         BorderRadius.circular(
//                             10),
//                         border: Border.all(
//                             color: items[index].status==0? AppColors.primaryTextColor:items[index].status==2?
//                             AppColors
//                                 .secondaryTextColor: Colors.green)),
//                     child: Center(
//                       child:  Text(
//                         items[index].status==2?'Failed':items[index].status==0?'Pending':'Succeed',
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight:
//                             FontWeight.w700,
//                             color:
//                             items[index].status==0?Colors.white:
//                             items[index].status==2?
//                             AppColors
//                                 .secondaryTextColor: Colors.green),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     items[index].status==0?'--':
//                     items[index].status==2?'- ₹${items[index].amount.toStringAsFixed(2)}':'+ ₹${items[index].winAmount.toStringAsFixed(2)}',
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight:
//                         FontWeight.w700,
//                         color: items[index].status==0?Colors.white:items[index].status==2?
//                         AppColors
//                             .secondaryTextColor: Colors.green),
//                   ),
//                 ],
//               ),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0),
//                   child: Column(
//                     mainAxisAlignment:
//                     MainAxisAlignment.start,
//                     crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       const Align(
//                           alignment:
//                           Alignment.topLeft,
//                           child: Text(
//                             'Details',
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight:
//                                 FontWeight
//                                     .w900,
//                                 color:
//                                 Colors.white),
//                           )),
//                       const SizedBox(height: 8.0),
//                       Container(
//                         height: height * 0.08,
//                         width: width,
//                         decoration: BoxDecoration(
//                             borderRadius:
//                             BorderRadius
//                                 .circular(10),
//                             color: AppColors
//                                 .FirstColor),
//                         child: Padding(
//                           padding:
//                           const EdgeInsets
//                               .all(8.0),
//                           child: Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment
//                                 .start,
//                             crossAxisAlignment:
//                             CrossAxisAlignment
//                                 .start,
//                             children: [
//                               const Text(
//                                 'order number',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight:
//                                     FontWeight
//                                         .w700,
//                                     color: Colors
//                                         .white),
//                               ),
//                               const SizedBox(
//                                   height: 4.0),
//                               Text(
//                                 items[index].orderId.toString(),
//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight:
//                                     FontWeight
//                                         .w700,
//                                     color: Colors
//                                         .white),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       historyDetails(
//                           'Period',
//                           items[index].gamesno.toString(),
//                           Colors.white),
//                       historyDetails(
//                           'Purchase amount',
//                           items[index].amount.toString(),
//                           Colors.white),
//                       historyDetails(
//                           'Amount after tax',
//                           items[index].tradeAmount.toString(),
//                           Colors.red),
//                       historyDetails('Tax',
//                           items[index].commission.toString(), Colors.white),
//                       historyWinDetails(
//                           'Result',
//                           items[index].winNumber==null? '--':
//                           '${items[index].winNumber}, ',
//                           items[index].winNumber==5?'Green White,':
//                           items[index].winNumber==0?'orange white,':
//                           items[index].winNumber==null? '':
//                           items[index].winNumber.isOdd?
//                           'green,':'orange,',
//                           items[index].winNumber==null? '':
//                           items[index].winNumber<5?
//                           'small':'Big',
//                           Colors.white,
//                           items[index].winNumber==null?Colors.orange:
//                           items[index].winNumber.isOdd?
//                           Colors.green:Colors.orange,
//                           items[index].winNumber==null?Colors.orange:
//                           items[index].winNumber<5?
//                           Colors.yellow:Colors.blue),
//                       historyDetails('Select',
//                           items[index].number==50?'small':items[index].number==40?'big':
//                           items[index].number==10?'Green':items[index].number==20?'White':
//                           items[index].number==30?'Orange':
//                           items[index].number.toString(), Colors.white),
//                       historyDetails('Status',
//                           items[index].status==0?'Unpaid':
//                           items[index].status==2?
//                           'Failed':'Succeed', items[index].status==0?Colors.white:items[index].status==2?Colors.red:Colors.green),
//                       historyDetails('Win/Loss',
//                           items[index].status==0?'--': '₹${items[index].winAmount.toStringAsFixed(2)}', items[index].status==0?Colors.white:items[index].status==2? Colors.red:Colors.green),
//                       historyDetails(
//                           'Order time',
//                           items[index].createdAt.toString(),
//                           Colors.white),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: limitResult == 0
//                   ? () {}
//                   : () {
//                 setState(() {
//                   pageNumber--;
//                   limitResult = limitResult - 10;
//                   offsetResult = offsetResult - 10;
//                 });
//                 setState(() {});
//                 BettingHistory();
//               },
//               child: Container(
//                 height: height * 0.06,
//                 width: width * 0.10,
//                 decoration: BoxDecoration(
//                   gradient: AppColors.loginSecondryGrad,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.navigate_before,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             textWidget(
//               text: '$pageNumber/ $totalBets',
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primaryTextColor,
//               maxLines: 1,
//             ),
//             const SizedBox(width: 16),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   limitResult = limitResult + 10;
//                   offsetResult = offsetResult + 10;
//                   pageNumber++;
//                 });
//                 setState(() {});
//                 BettingHistory();
//               },
//               child: Container(
//                 height: height * 0.06,
//                 width: width * 0.10,
//                 decoration: BoxDecoration(
//                   gradient: AppColors.loginSecondryGrad,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.navigate_next,
//                     color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//
//   UserViewProvider userProvider = UserViewProvider();
//
//
//
//   BaseApiHelper baseApiHelper = BaseApiHelper();
//   int? totalBets;
//
//   int? responseStatuscode;
//   List<BettingHistoryModel> items = [];
//   Future<void> BettingHistory() async {
//     UserModel user = await userProvider.getUser();
//     String token = user.id.toString();
//     final response = await http.get(
//       Uri.parse('${ApiUrl.betHistory}$token&game_id=$selectedIndex&limit=10&offset=$offsetResult'),
//     );
//     setState(() {
//       responseStatuscode = response.statusCode;
//     });
//
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = json.decode(response.body)['data'];
//       final Map<String, dynamic> Data = json.decode(response.body);
//       final int totalBetsCount = Data['total_bets'];
//       setState(() {
//         items = responseData.map((item) => BettingHistoryModel.fromJson(item)).toList();
//         totalBets=totalBetsCount;
//       });
//     } else if (response.statusCode == 400) {
//       if (kDebugMode) {
//         print('Data not found');
//       }
//     } else {
//       setState(() {
//         items = [];
//       });
//       throw Exception('Failed to load data');
//     }
//   }
//
//
//   historyDetails(String title, String subtitle, Color subColor) {
//     return Column(
//       children: [
//         const SizedBox(height: 8.0),
//         Container(
//           height: height * 0.05,
//           width: width,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: AppColors.FirstColor),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: subColor),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   historyWinDetails(String title, String subtitle, String subtitle1,
//       String subtitle2, Color subColor, Color subColor1, Color subColor2) {
//     return Column(
//       children: [
//         const SizedBox(height: 8.0),
//         Container(
//           height: height * 0.05,
//           width: width,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: AppColors.FirstColor),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: subColor),
//                     ),
//                     Text(
//                       subtitle1,
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: subColor1),
//                     ),
//                     Text(
//                       subtitle2,
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: subColor2),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   InkWell buildInkWell(int index, String text) {
//     bool isSelected = selectedIndex == index;
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//           offsetResult = 0;
//
//         });
//         BettingHistory();
//       },
//       child: Column(
//         children: [
//           textWidget(
//             text: text,
//             fontWeight: FontWeight.w900,
//             fontSize: 12,
//             color: AppColors.primaryTextColor,
//           ),
//           const SizedBox(height: 5,),
//           isSelected ?  Container(
//             height: 3,
//             width: 50,
//             color: isSelected ? Colors.blue : AppColors.gradientFirstColor,
//           ) :Container()
//
//         ],
//       ),
//     );
//   }
// }
// class Notfounddata extends StatelessWidget {
//   const Notfounddata({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image(
//           image: const AssetImage(Assets.imagesNoDataAvailable),
//           height: height / 3,
//           width: width / 2,
//         ),
//         SizedBox(height: height * 0.07),
//         const Text(
//           "Data not found",
//         )
//       ],
//     );
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/home/lottery/wingo/res/size_const.dart';
import 'package:globalbet/view/home/lottery/wingo/view_model/win_go_my_his_view_model.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/main.dart';


class WingoMyHis extends StatefulWidget {
  const WingoMyHis({super.key});

  @override
  State<WingoMyHis> createState() => _WingoMyHisState();
}

class _WingoMyHisState extends State<WingoMyHis> {
  int currentOffset = 0;
  int pageValue = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final winGoHisViewModel =
      Provider.of<WinGoMyHisViewModel>(context, listen: false);
      winGoHisViewModel.myBetHisApi(context,currentOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final winGoHisViewModel =
    Provider.of<WinGoMyHisViewModel>(context);
    if (winGoHisViewModel.winGoMyHisModelData != null &&
        winGoHisViewModel.winGoMyHisModelData!.data!.isNotEmpty) {
      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: winGoHisViewModel.winGoMyHisModelData!.data!.length,
            itemBuilder: (context, index) {
              final betHistoryData =
              winGoHisViewModel.winGoMyHisModelData!.data![index];
              final color = betHistoryData.number == 0
                  ? [Colors.red, Colors.purple]
                  : betHistoryData.number == 5
                  ? [Colors.green, Colors.purple]
                  : betHistoryData.number == 10
                  ? [Colors.green, Colors.green]
                  : betHistoryData.number == 20
                  ? [Colors.purple, Colors.purple]
                  : betHistoryData.number == 30
                  ? [Colors.red, Colors.red]
                  : betHistoryData.number == 40
                  ? [Colors.orange, Colors.orange]
                  : betHistoryData.number == 50
                  ? [Colors.blue, Colors.blue]
                  : (betHistoryData.number == 2 &&
                  betHistoryData.number == 4 &&
                  betHistoryData.number == 6 &&
                  betHistoryData.number == 8)
                  ? [Colors.red, Colors.red]
                  : [Colors.green, Colors.green];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: height * 0.066,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: color,
                          stops: const [0.5, 0.5],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: textWidget(
                        textAlign: TextAlign.center,
                        text: betHistoryData.number == 10
                            ? 'G'
                            : betHistoryData.number == 20
                            ? 'V'
                            : betHistoryData.number == 30
                            ? 'R'
                            : betHistoryData.number == 40
                            ? 'B'
                            : betHistoryData.number == 50
                            ? 'S'
                            : betHistoryData.number.toString(),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: textWidget(
                      textAlign: TextAlign.left,
                      text: betHistoryData.gamesNo.toString(),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                    subtitle: textWidget(
                      textAlign: TextAlign.left,
                      text: betHistoryData.createdAt,
                      fontSize: 10,
                      color: AppColors.whiteColor,
                    ),
                    trailing: Column(
                      children: [
                        AppBtn(
                          height: height * 0.04,
                          width: width * 0.2,
                          title: betHistoryData.status == 0
                              ? "Pending"
                              : betHistoryData.status == 1
                              ? "Success"
                              : "Failed",
                          // color: Colors.red,
                          fontWeight: FontWeight.bold,
                          titleColor: betHistoryData.status == 0
                              ? Colors.orange
                              : betHistoryData.status == 1
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                          gradient: AppColors.transparentgradient,
                          border: Border.all(
                            color: betHistoryData.status == 0
                                ? Colors.orange
                                : betHistoryData.status == 1
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        Sizes.spaceHeight5,
                        textWidget(
                          text: "₹ ${(betHistoryData.status == 1?betHistoryData.winAmount:betHistoryData.amount).toStringAsFixed(2)}",
                          fontSize: 12,
                          color: betHistoryData.status == 0
                              ? Colors.orange
                              : betHistoryData.status == 1
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textWidget(
                                text: "",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            wingoGameHistoryDetail(
                              "Order Number",
                              betHistoryData.orderId.toString(),
                              Colors.orangeAccent,
                            ),
                            wingoGameHistoryDetail(
                              "Period",
                              betHistoryData.gamesNo.toString(),
                              Colors.orangeAccent,
                            ),
                            wingoGameHistoryDetail(
                              "Purchase Amount",
                              "₹${betHistoryData.amount}",
                              Colors.white,
                            ),
                            wingoGameHistoryDetail(
                              "Amount after TAX",
                              "₹ ${betHistoryData.tradeAmount}",
                              Colors.green,
                            ),
                            wingoGameHistoryDetail(
                              "TAX",
                              "₹ ${betHistoryData.commission}",
                              Colors.green,
                            ),
                            wingoGameHistoryDetail(
                              "Result",
                              betHistoryData.winNumber.toString(),
                              Colors.green,
                            ),
                            wingoGameHistoryDetail(
                              "Select",
                              betHistoryData.winNumber.toString(),
                              Colors.green,
                            ),
                            wingoGameHistoryDetail(
                              "Status",
                              betHistoryData.status == 0
                                  ? "Pending"
                                  : betHistoryData.status == 1
                                  ? "Success"
                                  : "Failed",
                              Colors.red,
                            ),
                            wingoGameHistoryDetail(
                              "Win/Loss",
                              "₹ ${betHistoryData.winAmount.toStringAsFixed(2)}",
                              Colors.red,
                            ),
                            wingoGameHistoryDetail(
                              "Order Time",
                              betHistoryData.createdAt.toString(),
                              Colors.green,
                            ),
                            SizedBox(height: height * 0.01),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (pageValue != 1) {
                    _decrementData(winGoHisViewModel);
                  }
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.10,
                  decoration: BoxDecoration(
                    gradient: pageValue ==1
                        ? AppColors.boxGradient:AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.navigate_before,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Sizes.spaceWidth15,
              Row(
                children: [
                  Text(
                    pageValue.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Text(
                    '/',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                      // maxLines: 1,
                    ),
                  ),
                  Text(
                    (((winGoHisViewModel.winGoMyHisModelData!.totalBets! - 1) ~/ 10) + 1).toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                      // maxLines: 1,
                    ),
                  ),
                ],
              ),
              Sizes.spaceWidth15,
              GestureDetector(
                onTap: () {
                  if (pageValue !=
                      ((winGoHisViewModel.winGoMyHisModelData!.totalBets! - 1) ~/ 10) + 1) {
                    _incrementData(winGoHisViewModel);
                  }
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.10,
                  decoration: BoxDecoration(
                    gradient: pageValue ==
                        ((winGoHisViewModel.winGoMyHisModelData!.totalBets! -
                            1) ~/
                            10) +
                            1
                        ? AppColors.boxGradient:AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  const Icon(Icons.navigate_next,
                      color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Container(
          height: height * 0.2,
          width: width,
          alignment: Alignment.center,
          child: const Text('No data available!',
              style: TextStyle(color: Colors.white)));
    }
  }

  void _updateData(int increment, WinGoMyHisViewModel winGoHisViewModel) {
    if (winGoHisViewModel.winGoMyHisModelData!.totalBets != null &&
        winGoHisViewModel.winGoMyHisModelData!.totalBets != null) {
      int countValue = winGoHisViewModel.winGoMyHisModelData!.totalBets!;
      if ((currentOffset + increment >= 0) &&
          (currentOffset + increment < countValue)) {
        currentOffset += increment;
        pageValue += increment ~/ 10;
        winGoHisViewModel.myBetHisApi(context,currentOffset);
      } else {
        if (kDebugMode) {
          print('No data available');
        }
      }
    }
  }

  void _incrementData(WinGoMyHisViewModel winGoHisViewModel) {
    _updateData(10,winGoHisViewModel);
  }

  void _decrementData(WinGoMyHisViewModel winGoHisViewMode) {
    _updateData(-10,winGoHisViewMode);
  }

  Widget wingoGameHistoryDetail(
      String label,
      String value,
      Color colorTwo) {
    return Container(
      height: height * 0.06,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(
            text: label,
            fontSize: width * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textWidget(
            text: value,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colorTwo,
          ),
        ],
      ),
    );
  }
}
