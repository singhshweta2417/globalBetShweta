// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:globalbet/generated/assets.dart';
// import 'package:globalbet/main.dart';
// import 'package:globalbet/res/aap_colors.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:globalbet/res/components/app_bar.dart';
// import 'package:globalbet/res/components/text_field.dart';
// import 'package:globalbet/res/provider/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:globalbet/utils/utils.dart';
//
// import '../../res/components/text_widget.dart';
//
// class Testinggg extends StatefulWidget {
//   const Testinggg({super.key});
//
//   @override
//   State<Testinggg> createState() => _TestingggState();
// }
//
// class _TestingggState extends State<Testinggg> {
//
//   bool selectedButton = true;
//   bool hidePassword = true;
//   bool rememberPass = false;
//   bool activeButton = true;
//   TextEditingController phoneCon = TextEditingController();
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passwordCon = TextEditingController();
//   TextEditingController passwordConn = TextEditingController();
//
//   /// Check internet
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       // ignore: avoid_print
//       print(e.toString());
//       return;
//     }
//
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//   }
//
//   @override
//   void initState() {
//     initConnectivity();
//     super.initState();
//   }
//
//   Future<bool> _onWillPop() async {
//     bool shouldExit = await Utils.showExitConfirmation(context) ?? false;
//     return shouldExit;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<UserAuthProvider>(context);
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: GradientAppBar(
//             centerTitle: true,
//             title: textWidget(
//                 text: 'Test Bet',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 28,
//                 color: AppColors.whiteColor),
//             gradient: AppColors.primaryGradient),
//         body: _connectionStatus == ConnectivityResult.none
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Image(
//                       image: const AssetImage(Assets.imagesNoDataAvailable),
//                       height: MediaQuery.of(context).size.height / 3,
//                       width: MediaQuery.of(context).size.width / 2,
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: Text('There is no Internet connection'),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: Text('Please check your Internet connection'),
//                   ),
//                 ],
//               )
//             : Container(
//                 padding: const EdgeInsets.all(20),
//                 alignment: Alignment.center,
//                 decoration:
//                     const BoxDecoration(gradient: AppColors.primaryGradient),
//                 child: Container(
//                   height: height * 0.8,
//                   decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectedButton = !selectedButton;
//                                 activeButton = !activeButton;
//                               });
//                             },
//                             child: Container(
//                               height: height*0.1,
//                               width: width*0.445,
//                               decoration: BoxDecoration(
//                                 gradient: selectedButton
//                                     ? AppColors.loginSecondaryGrad
//                                     : AppColors.unSelectedColor,
//                                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20))
//                               ),
//                               child: Center(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedButton = !selectedButton;
//                                       activeButton = !activeButton;
//                                     });
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       selectedButton
//                                           ? Image.asset(
//                                         Assets.iconsPhoneTabColor,
//                                         scale: 1.5,
//                                         color: AppColors.whiteColor,
//                                       )
//                                           : Image.asset(
//                                         Assets.iconsPhoneTab,
//                                         scale: 1.5,
//                                         color: AppColors.primaryContColor,
//                                       ),
//                                       textWidget(
//                                         text: 'Log in with phone',
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16,
//                                         color: selectedButton
//                                             ? AppColors.primaryContColor
//                                             : AppColors.whiteColor,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectedButton = !selectedButton;
//                                 activeButton = !activeButton;
//                               });
//                             },
//                             child: Container(
//                               height: height*0.1,
//                               width: width*0.445,
//                               decoration: BoxDecoration(
//                                   gradient: !selectedButton
//                                       ? AppColors.loginSecondaryGrad
//                                       : AppColors.unSelectedColor,
//                                   borderRadius: const BorderRadius.only(topRight: Radius.circular(20))
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   !selectedButton
//                                       ? Image.asset(
//                                     Assets.iconsEmailTabColor,
//                                     scale: 1.5,
//                                     color: AppColors.whiteColor,
//                                   )
//                                       : Image.asset(
//                                     Assets.iconsEmailTab,
//                                     scale: 1.5,
//                                     color:AppColors.primaryContColor,
//                                   ),
//                                   textWidget(
//                                     text: 'Email Login',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                     color: !selectedButton
//                                         ? AppColors.primaryContColor
//                                         : AppColors.whiteColor,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       selectedButton
//                           ? Row(
//                         children: [
//                           Expanded(
//                               child: CustomTextField(
//                                 onChanged: (value) {
//                                   if (phoneCon.text.length == 10) {
//                                     setState(() {
//                                       activeButton = !activeButton;
//                                     });
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: phoneCon,
//                                 maxLength: 10,
//                                 hintText: 'Please enter the phone number',
//                                 fillColor: Colors.black,
//                                 fieldRadius: BorderRadius.circular(0),
//                                 prefixIcon: SizedBox(
//                                   width: width*0.2,
//                                   child:Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Image.asset(
//                                         selectedButton
//                                             ? Assets.iconsPhone
//                                             : Assets.iconsEmailTab,
//                                         scale: 2.5,
//                                           color: AppColors.primaryContColor
//                                       ),
//                                       textWidget(text: ' +91 |',fontSize: 20,color: AppColors.primaryContColor),
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                         ],
//                       )
//                           : CustomTextField(
//                         onChanged: (value) {
//                           if (emailCon.text.isNotEmpty) {
//                             setState(() {
//                               activeButton = !activeButton;
//                             });
//                           }
//                         },
//                         controller: emailCon,
//                         maxLines: 1,
//                         hintText: 'please input your email',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
