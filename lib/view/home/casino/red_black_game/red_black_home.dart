// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
// import 'package:flutter_flip_card/flipcard/flip_card.dart';
// import 'package:flutter_flip_card/modal/flip_side.dart';
// import 'package:game_on/generated/assets.dart';
// import 'package:game_on/res/api_urls.dart';
// import 'package:game_on/res/view_model/profile_view_model.dart';
// import 'package:game_on/view/home/casino/andar_bahar/andar_bahar_assets.dart';
// import 'package:game_on/view/home/casino/andar_bahar/andar_bahar_model/last_fifteen.dart';
// import 'package:game_on/view/home/casino/andar_bahar/constant/coins_sign_new.dart';
// import 'package:game_on/view/home/casino/andar_bahar/constant/hide_coins.dart';
// import 'package:game_on/view/home/casino/andar_bahar/constant/image_toast_wingo.dart';
// import 'package:game_on/view/home/casino/dragon_tiger_new/widgets/dragon_tiger_assets.dart';
// import 'package:game_on/view/home/casino/fun_target/Constant/color.dart';
// import 'package:game_on/view/home/casino/red_black_game/red_black_help_page.dart';
// import 'package:game_on/view/home/casino/red_black_game/red_black_history.dart';
// import 'package:game_on/view/home/casino/red_black_game/red_black_loading.dart';
// import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/circular_timer_dependency.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../utils/utils.dart';
// import '../../mini/Aviator/widget/image_toast.dart';
//
// class RedBlackHomepage extends StatefulWidget {
//   final String gameId;
//   const RedBlackHomepage({
//     super.key,
//     required this.gameId,
//   });
//
//   @override
//   State<RedBlackHomepage> createState() => _RedBlackHomepageState();
// }
//
// class _RedBlackHomepageState extends State<RedBlackHomepage> {
//   @override
//   void initState() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.initState();
//     startCountdown();
//     fetchData();
//   }
//
//   final cardFlip = FlipCardController();
//   int countdownSeconds = 30;
//   Timer? countdownTimer;
//   int secondsElapsed = 20;
//   Timer? secondTimer;
//   bool isRunning = false;
//   bool hideButton = false;
//   bool FirstCome = false;
//
//   void startCountdown() {
//     DateTime now = DateTime.now().toUtc();
//     int initialSeconds = 60 - now.second; // Calculate initial remaining seconds
//     setState(() {
//       countdownSeconds = initialSeconds;
//     });
//
//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       updateUI();
//     });
//   }
//
//   void updateUI() {
//     final profileProvider =
//         Provider.of<ProfileViewModel>(context, listen: false);
//
//     setState(() {
//       if (countdownSeconds == 29) {
//         profileProvider.profileApi(context);
//         wallet =
//             double.parse(context.read<ProfileViewModel>().balance.toString());
//         _handleFlipCards(countdownSeconds);
//         if (FirstCome == false) {
//         } else {
//           ImageToast.show(
//               imagePath: AppAssets.dragontigerStartbetting,
//               heights: 100,
//               context: context);
//
//           isRunning = true;
//           startSecondTimer();
//           hideButton = false;
//           // dice=true;
//         }
//       } else if (countdownSeconds == 15) {
//         if (FirstCome == false) {
//         } else {
//           ImageToast.show(
//               imagePath: AppAssets.dragontigerStopbetting,
//               heights: 100,
//               context: context);
//           hideButton = true;
//         }
//       } else if (countdownSeconds == 10) {
//         if (FirstCome == false) {
//         } else {
//           if (redCount == 0 &&
//               blackCount == 0 &&
//               heartCount == 0 &&
//               clubCount == 0 &&
//               spadeCount == 0 &&
//               diamondCount == 0 &&
//               jokerCount == 0) {
//           } else {
//             bettingApi(context);
//           }
//         }
//       } else if (countdownSeconds == 6) {
//         if (FirstCome == false) {
//         } else {
//           if (isRunning) {
//             lastResultView();
//             resetSecondTimer();
//             wallet = 10;
//           }
//         }
//         _handleFlipCards(countdownSeconds);
//       } else if (countdownSeconds == 1) {
//         fetchData();
//         countAndCoinClear();
//         gameWinPopup(context);
//         FirstCome = true;
//       }
//       countdownSeconds = (countdownSeconds - 1) % 30;
//     });
//   }
//
//   void startSecondTimer() {
//     secondTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       setState(() {
//         if (secondsElapsed > 0) {
//           secondsElapsed--;
//         } else {
//           secondTimer?.cancel();
//         }
//       });
//     });
//   }
//
//   void resetSecondTimer() {
//     secondTimer?.cancel();
//     setState(() {
//       secondsElapsed = 20;
//       isRunning = false;
//     });
//   }
//
//   void _handleFlipCards(int newCountdownSeconds) {
//     cardFlip.flipcard();
//
//     countdownSeconds = newCountdownSeconds;
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     wallet = 10;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return FirstCome == false
//         ? RedBlackLoading(time: int.parse(countdownSeconds.toString()))
//         : Scaffold(
//             backgroundColor: ColorConstant.darkBlackColor,
//             body: Container(
//               height: height,
//               width: width,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(Assets.redBlackImgRedBlackBg),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 5.0, right: 10, left: 15),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                             SystemChrome.setPreferredOrientations([
//                               DeviceOrientation.landscapeLeft,
//                               DeviceOrientation.landscapeRight,
//                             ]);
//                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
//                           },
//                           child: Container(
//                             height: height * 0.08,
//                             width: width * 0.05,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(AndarAssets.andarbaharBack),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 5.0, right: 10, left: 15),
//                         child: InkWell(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return const HelpPopup();
//                               },
//                             );
//                           },
//                           child: Container(
//                             height: height * 0.07,
//                             width: width * 0.05,
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     AndarAssets.andarbaharIcJackpotInfo),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: height * 0.89,
//                     width: width * 0.88,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(Assets.redBlackImgRedBlackBottomBg),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(height: height * 0.14),
//                         Row(
//                           children: [
//                             SizedBox(width: width * 0.07),
//                             Container(
//                               alignment: Alignment.topCenter,
//                               height: height * 0.04,
//                               width: width * 0.14,
//                               child: Center(
//                                 child: Text(
//                                   wallet.toString(),
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w900,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: width * 0.02),
//                             Container(
//                               height: height * 0.045,
//                               width: width * 0.6,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                     Assets.redBlackImgPlazaBtnNotice0,
//                                   ),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(countdownSeconds.toString()),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: height * 0.01),
//                         Row(
//                           children: [
//                             SizedBox(width: width * 0.033),
//                             Container(
//                               height: height * 0.32,
//                               width: width * 0.19,
//                               color: ColorConstant.textColor12,
//                               child: Center(
//                                 child: FlipCard(
//                                   rotateSide: RotateSide.bottom,
//                                   controller: cardFlip,
//                                   animationDuration:
//                                       const Duration(milliseconds: 800),
//                                   axis: FlipAxis.horizontal,
//                                   frontWidget: Image.network(
//                                     winResult.toString(),
//                                     fit: BoxFit.fill,
//                                   ),
//                                   backWidget: Stack(children: [
//                                     Image.asset(
//                                       AppAssets.imageFireCard,
//                                       fit: BoxFit.fill,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 35.0, left: 14),
//                                       child: Container(
//                                         decoration: const BoxDecoration(
//                                             color: Colors.black,
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(28))),
//                                         child: CircularPercentIndicator(
//                                           lineWidth: 2,
//                                           reverse: true,
//                                           radius: width * 0.044,
//                                           backgroundColor: Colors.green,
//                                           progressColor: Colors.grey,
//                                           percent: double.parse(
//                                               (secondsElapsed / 20).toString()),
//                                           center: Text(
//                                             '$secondsElapsed',
//                                             style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w900,
//                                               color: Colors.green,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: height * 0.02),
//                             Container(
//                               height: height * 0.32,
//                               width: width * 0.59,
//                               color: ColorConstant.textColor12,
//                               child: Center(
//                                 child: GridView.builder(
//                                     physics: const BouncingScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: items
//                                         .length, // Increase itemCount by 1 for the additional item
//                                     gridDelegate:
//                                         const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 10,
//                                       crossAxisSpacing: 4,
//                                       mainAxisSpacing: 4,
//                                       childAspectRatio: 1.0,
//                                     ),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       // For the last index
//                                       return Stack(
//                                         children: [
//                                           Container(
//                                             height: 50,
//                                             width: 50,
//                                             decoration: BoxDecoration(
//                                               image: DecorationImage(
//                                                 image: NetworkImage(items[index]
//                                                     .images
//                                                     .toString()),
//                                                 fit: BoxFit.fill,
//                                               ),
//                                             ),
//                                           ),
//                                           index == 0
//                                               ? Positioned(
//                                                   top: -2,
//                                                   right: -2,
//                                                   child: Container(
//                                                     height: 15,
//                                                     width: 20,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: AssetImage(Assets
//                                                             .redBlackImgNew),
//                                                         fit: BoxFit.fill,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Container()
//                                         ],
//                                       );
//                                     }),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: height * 0.03),
//                         // SizedBox(height: height * 0.01),
//                         Container(
//                           alignment: Alignment.topLeft,
//                           height: height * 0.155,
//                           width: width * 0.815,
//                           child: Row(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 1;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.center,
//                                       height: height * 0.081,
//                                       width: width * 0.103,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 1
//                                               ? const Color(0xfffbbb2f)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           spadeCount != 0
//                                               ? "₹${spadeCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.103,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: width * 0.008),
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 2;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.081,
//                                       width: width * 0.103,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 2
//                                               ? const Color(0xfffbbb2f)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           heartCount != 0
//                                               ? "₹${heartCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.103,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: width * 0.008),
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 3;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.081,
//                                       width: width * 0.103,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 3
//                                               ? const Color(0xfffbbb2f)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           clubCount != 0
//                                               ? "₹${clubCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.103,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: width * 0.008),
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 4;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.081,
//                                       width: width * 0.103,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 4
//                                               ? const Color(0xfffbbb2f)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           diamondCount != 0
//                                               ? "₹${diamondCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.103,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: width * 0.008),
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 5;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.081,
//                                       width: width * 0.103,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 5
//                                               ? const Color(0xfffbbb2f)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           jokerCount != 0
//                                               ? "₹${jokerCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.103,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: width * 0.008),
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 6;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.081,
//                                       width: width * 0.125,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 6
//                                               ? const Color(0xff0bb8e0)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           blackCount != 0
//                                               ? "₹${blackCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.125,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: width * 0.008),
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedCart = 7;
//                                   });
//                                 },
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.081,
//                                       width: width * 0.125,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: selectedCart == 7
//                                               ? const Color(0xfff97a6b)
//                                               : Colors.transparent,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           redCount != 0
//                                               ? "₹${redCount.toString()}"
//                                               : "",
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.074,
//                                       width: width * 0.125,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Stack(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: width * 0.05, top: height * 0.035),
//                                   child: Container(
//                                     height: height * 0.08,
//                                     width: width * 0.17,
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                             AndarAssets.andarbaharPlayerWallet),
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       wallet.toString(),
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14,
//                                           color: Colors.white),
//                                     )),
//                                     // color: Colors.red,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: width * 0.18, top: height * 0.045),
//                                   child: Container(
//                                     height: height * 0.06,
//                                     width: width * 0.08,
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                             AndarAssets.andarbaharAddIconNew),
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                     // color: Colors.red,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(top: height * 0.02),
//                                   child: const CircleAvatar(
//                                     radius: 20,
//                                     backgroundImage:
//                                         AssetImage(AndarAssets.andarbaharIcons),
//                                     child: CircleAvatar(
//                                       radius: 18,
//                                       // backgroundImage: NetworkImage(context
//                                       //     .watch<MyModel>()
//                                       //     .image
//                                       //     .toString()),
//                                       backgroundColor: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: width * 0.02,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     PageTransition(
//                                         child:
//                                             const RedBlackGameHistoryScreen(),
//                                         type: PageTransitionType.topToBottom,
//                                         duration:
//                                             const Duration(milliseconds: 500)));
//                               },
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     height: height * 0.075,
//                                     width: height * 0.085,
//                                     decoration: const BoxDecoration(
//                                         image: DecorationImage(
//                                       image:
//                                           AssetImage(Assets.headTailBetHistory),
//                                       fit: BoxFit.fill,
//                                     )),
//                                   ),
//                                   const Text(
//                                     'History',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w900,
//                                         fontSize: 8,
//                                         color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: width * 0.02,
//                             ),
//                             SizedBox(
//                               height: height * 0.12,
//                               width: width * 0.43,
//                               // color: Colors.yellow,
//                               child: SizedBox(
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: list.length,
//                                   scrollDirection: Axis.horizontal,
//                                   itemBuilder: (context, int index) {
//                                     return hideButton == true
//                                         ? HideCoins(list[index])
//                                         : InkWell(
//                                             onTap: () async {
//                                               wallet == null
//                                                   ? Utils.flushBarErrorMessage(
//                                                       'Please Recharge',
//                                                       context,
//                                                       Colors.red)
//                                                   : wallet! < list[index]
//                                                       ? Utils
//                                                           .flushBarErrorMessage(
//                                                               'Low Balance',
//                                                               context,
//                                                               Colors.red)
//                                                       : Future.delayed(
//                                                           Duration.zero, () {
//                                                           if (selectedCart ==
//                                                               1) {
//                                                             CoindesignNew(
//                                                                 list[index]);
//                                                           } else if (selectedCart ==
//                                                               2) {
//                                                             CoindesignNew(
//                                                                 list[index]);
//                                                           } else if (selectedCart ==
//                                                               3) {
//                                                             CoindesignNew(
//                                                                 list[index]);
//                                                           } else if (selectedCart ==
//                                                               4) {
//                                                             CoindesignNew(
//                                                                 list[index]);
//                                                           } else if (selectedCart ==
//                                                               5) {
//                                                             CoindesignNew(
//                                                                 list[index]);
//                                                           } else {
//                                                             CoindesignNew(
//                                                                 list[index]);
//                                                           }
//                                                           setState(() {
//                                                             if (selectedCart ==
//                                                                 1) {
//                                                               spadeCount =
//                                                                   spadeCount +
//                                                                       list[
//                                                                           index];
//                                                             } else if (selectedCart ==
//                                                                 2) {
//                                                               heartCount =
//                                                                   heartCount +
//                                                                       list[
//                                                                           index];
//                                                             } else if (selectedCart ==
//                                                                 3) {
//                                                               clubCount =
//                                                                   clubCount +
//                                                                       list[
//                                                                           index];
//                                                             } else if (selectedCart ==
//                                                                 4) {
//                                                               diamondCount =
//                                                                   diamondCount +
//                                                                       list[
//                                                                           index];
//                                                             } else if (selectedCart ==
//                                                                 5) {
//                                                               jokerCount =
//                                                                   jokerCount +
//                                                                       list[
//                                                                           index];
//                                                             } else if (selectedCart ==
//                                                                 6) {
//                                                               blackCount =
//                                                                   blackCount +
//                                                                       list[
//                                                                           index];
//                                                             } else {
//                                                               redCount =
//                                                                   redCount +
//                                                                       list[
//                                                                           index];
//                                                             }
//                                                           });
//                                                         });
//
//                                               deductAmount(
//                                                 list[index],
//                                               );
//                                             },
//                                             child: CoindesignNew(list[index]),
//                                           );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//   }
//
//   gameWinPopup(context) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     final response = await http.post(
//       Uri.parse(ApiUrl.winAmount),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         "userid": userid.toString(),
//         "game_id": widget.gameId.toString(),
//         "game_no": gamesNo.toString()
//       }),
//     );
//
//     var data = jsonDecode(response.body);
//     if (data["status"] == 200) {
//       var win = data["win"].toString();
//       var result = data["result"].toString();
//       var gsm = data["gamesno"].toString();
//       win == '0'
//           ? ImageToastWingo.showloss(
//               subtext: result, subtext1: gsm, subtext2: win, context: context)
//           : ImageToastWingo.showwin(
//               subtext: result,
//               subtext1: gsm,
//               subtext2: win,
//               context: context,
//             );
//     } else {
//       setState(() {
//         // loadingGreen = false;
//       });
//       // Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
//     }
//   }
//
//   List<LastFifteen> items = [];
//
//   Future<void> fetchData() async {
//     var gameids = widget.gameId;
//     final response =
//         await http.get(Uri.parse("${ApiUrl.result}$gameids&limit=30"));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = json.decode(response.body)['data'];
//
//       setState(() {
//         items = responseData.map((item) => LastFifteen.fromJson(item)).toList();
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
//   // *betting API*  //
//   bettingApi(context) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     final betList = [
//       {'number': '1', 'amount': heartCount.toString()},
//       {'number': '2', 'amount': clubCount.toString()},
//       {'number': '3', 'amount': spadeCount.toString()},
//       {'number': '4', 'amount': diamondCount.toString()},
//       {'number': '5', 'amount': redCount.toString()},
//       {'number': '6', 'amount': blackCount.toString()},
//       {'number': '7', 'amount': jokerCount.toString()},
//     ];
//     final response = await http.post(
//       Uri.parse(ApiUrl.betPlaced),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         "userid": userid,
//         "game_id": widget.gameId,
//         "json": betList,
//       }),
//     );
//
//     var data = jsonDecode(response.body);
//     if (data["status"] == 200) {
//       ImageToast.show(
//           imagePath: AppAssets.bettingplaceds, heights: 100, context: context);
//       //  countandcoinclear();
//     } else {
//       Utils.flushBarErrorMessage(data['msg'], context, Colors.red);
//     }
//   }
//
//   var winResult;
//   var gamesNo;
//   List<String> stringList = [];
//   lastResultView() async {
//     var gameIds = widget.gameId;
//     try {
//       final url = Uri.parse('${ApiUrl.result}$gameIds&limit=1');
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body)["data"][0];
//         setState(() {
//           winResult = responseData["random_card"];
//           gamesNo = int.parse(responseData["gamesno"].toString()) + 1;
//         });
//       } else {
//         throw Exception(
//             "Failed to load data. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Failed to load data. $e");
//     }
//   }
//
//   int selectedCart = 0;
//   dynamic wallet = 0;
//   int heartCount = 0;
//   int spadeCount = 0;
//   int diamondCount = 0;
//   int clubCount = 0;
//   int jokerCount = 0;
//   int blackCount = 0;
//   int redCount = 0;
//   void countAndCoinClear() {
//     setState(() {
//       heartCount = 0;
//       spadeCount = 0;
//       diamondCount = 0;
//       clubCount = 0;
//       jokerCount = 0;
//       blackCount = 0;
//       redCount = 0;
//       selectedCart = 0;
//     });
//   }
//
//   void deductAmount(int amountToDeduct) {
//     if (wallet! >= amountToDeduct) {
//       setState(() {
//         wallet = (wallet! - amountToDeduct).toInt();
//       });
//     } else {
//       Utils.flushBarErrorMessage('Insufficient funds', context, Colors.red);
//       // Handle insufficient funds scenario, e.g., show a message to the user
//     }
//   }
//
//   List<int> list = [1, 5, 10, 50, 100, 500, 1000];
//
//   @override
//   void dispose() {
//     if (secondTimer!.isActive) {
//       secondTimer!.cancel();
//     }
//     // countdownSeconds.cancel();
//     super.dispose();
//   }
// }
