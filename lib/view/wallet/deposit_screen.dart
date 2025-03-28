import 'dart:convert';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/add_account_view_model.dart';
import 'package:game_on/model/deposit_model_new.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/audio.dart';
import 'package:game_on/res/components/text_field.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/helper/api_helper.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/wallet/deposit_history.dart';
import 'package:game_on/view/wallet/deposit_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class GridChange {
  String title;
  String images;
  GridChange(this.title, this.images);
}

class DepositScreen extends StatefulWidget {
  final AddacountViewModel? account;
  const DepositScreen({super.key, this.account});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  bool loading = false;

  @override
  void initState() {
    Audio.depositmusic();
    getWaySelect();
    invitationRuleApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Audio.audioPlayers;
    // TODO: implement dispose
    super.dispose();
  }

  int selectedIndex = 0;
  int selectIndex = 1;

  int result = 0;
  String results = "";

  TextEditingController depositCon = TextEditingController();
  TextEditingController usdtCon = TextEditingController();
  TextEditingController camelCon = TextEditingController();
  String selectedDeposit = '';
  String selectedUsdt = '';

  BaseApiHelper baseApiHelper = BaseApiHelper();

  List<int> listNew = [200, 500, 1000, 2000, 5000, 10000];

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = width / height;
    final userData = Provider.of<ProfileViewModel>(context);

    int? responseStatusCode;

    return Scaffold(
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Audio.audioPlayers.stop();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'Deposit',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DepositHistory()));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textWidget(
                    text: 'Deposit history',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
          gradient: AppColors.unSelectedColor),
      body: Container(
        height: height,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: const BoxDecoration(gradient: AppColors.bgGrad),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            Container(
              height: height * 0.22,
              width: width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage(Assets.imagesCardImage),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(Assets.iconsDepoWallet, height: 30),
                          const SizedBox(width: 15),
                          textWidget(
                              text: 'Balance',
                              fontSize: 20,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                              fontSize: 20),
                          textWidget(
                            text: userData.balance.toStringAsFixed(2),
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                              onTap: () {
                                userData.profileApi(context);
                                Utils.flushBarSuccessMessage(
                                    'Wallet refresh ✔', context, Colors.white);
                              },
                              child: Image.asset(
                                Assets.iconsTotalBal,
                                height: 30,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            responseStatusCode == 400
                ? const NotFoundData()
                : items.isEmpty
                    ? Container()
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final currentId =
                              int.parse(items[index].type.toString());

                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = currentId;
                              });
                              Audio.audioPlayers.play();
                            },
                            child: Card(
                              elevation: selectedIndex == currentId ? 2 : 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: selectedIndex == currentId
                                      ? AppColors.loginSecondaryGrad
                                      : AppColors.unSelectedColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    items[index].image != null
                                        ? Image.network(
                                            items[index].image.toString(),
                                            height: 45,
                                          )
                                        : const Placeholder(
                                            fallbackHeight: 45,
                                          ),
                                    textWidget(
                                        text: items[index].name.toString(),
                                        fontSize: 13,
                                        color: selectedIndex == currentId
                                            ? AppColors.whiteColor
                                            : AppColors.whiteColor,
                                        fontWeight: FontWeight.w900),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

            const SizedBox(
              height: 20,
            ),

            selectedIndex == 1
                ? Container(
                    height: height * 0.33,
                    width: width,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                        gradient: AppColors.unSelectedColor,
                        borderRadius: BorderRadiusDirectional.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.iconsSaveWallet,
                              height: height * 0.05,
                            ),
                            const SizedBox(width: 15),
                            textWidget(
                                text: 'Deposit amount',
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColors.whiteColor),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width,
                          height: height * 0.123,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 3,
                                    childAspectRatio: aspectRatio * 4.8),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listNew.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectIndex = listNew[index];
                                    depositCon.text = listNew[index].toString();
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      color: selectIndex == listNew[index]
                                          ? AppColors.whiteColor
                                          : AppColors.darkColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        listNew[index].toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: selectIndex == listNew[index]
                                              ? Colors.white
                                              : AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          fillColor: AppColors.darkColor,
                          hintText: 'Please add the amount',
                          fieldRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30)),
                          textColor: Colors.white,
                          keyboardType: TextInputType.number,
                          fontWeight: FontWeight.w600,
                          controller: depositCon,
                          onChanged: (value) {
                            selectIndex != depositCon;
                            selectIndex = -1;
                          },
                          prefixIcon: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                                    fontSize: 20),
                                const SizedBox(width: 10),
                                Container(
                                    height: 30, color: Colors.grey, width: 2)
                              ],
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                depositCon.clear();
                                selectIndex = -1;
                                selectedDeposit = '';
                              });
                            },
                            icon: const Icon(Icons.cancel_outlined,
                                color: AppColors.dividerColor),
                          ),
                        ),
                      ],
                    ),
                  )
                : selectedIndex == 0
                    ? Container(
                        width: width,
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        decoration: BoxDecoration(
                            gradient: AppColors.unSelectedColor,
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.imagesUsdtIcon,
                                  height: height * 0.05,
                                ),
                                const SizedBox(width: 15),
                                textWidget(
                                    text: 'USDT amount',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.whiteColor),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              fillColor: AppColors.darkColor,
                              hintText: 'Please add usdt amount',
                              fieldRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              textColor: Colors.white,
                              keyboardType: TextInputType.number,
                              fontWeight: FontWeight.w600,
                              controller: usdtCon,
                              onChanged: (value) {
                                setState(() {
                                  double amount = double.tryParse(value) ?? 0;
                                  results = (amount * 91).toStringAsFixed(2);
                                });
                              },
                              prefixIcon: SizedBox(
                                width: 70,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Image.asset(
                                      Assets.imagesUsdtIcon,
                                      height: height * 0.03,
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                        height: 30,
                                        color: Colors.white,
                                        width: 2)
                                  ],
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    usdtCon.clear();
                                    selectedUsdt = '';
                                    results = "";
                                  });
                                },
                                icon: const Icon(Icons.cancel_outlined,
                                    color: AppColors.dividerColor),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              'Total amount in Rupees: ${results.isNotEmpty ? "$results Rs" : "0 Rs"}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.whiteColor),
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      )
                    : Container(
                        height: height * 0.33,
                        width: width,
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        decoration: BoxDecoration(
                            gradient: AppColors.unSelectedColor,
                            borderRadius: BorderRadiusDirectional.circular(15)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.iconsSaveWallet,
                                  height: height * 0.05,
                                ),
                                const SizedBox(width: 15),
                                textWidget(
                                    text: 'Deposit amount',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.whiteColor),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.123,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 3,
                                        childAspectRatio: aspectRatio * 4.8),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listNew.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectIndex = listNew[index];
                                        camelCon.text =
                                            listNew[index].toString();
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                        height: height * 0.05,
                                        decoration: BoxDecoration(
                                          color: selectIndex == listNew[index]
                                              ? AppColors.whiteColor
                                              : AppColors.darkColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Center(
                                          child: Text(
                                            listNew[index].toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              color:
                                                  selectIndex == listNew[index]
                                                      ? Colors.white
                                                      : AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              fillColor: AppColors.darkColor,
                              hintText: 'Please add the amount',
                              fieldRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              textColor: Colors.white,
                              keyboardType: TextInputType.number,
                              fontWeight: FontWeight.w600,
                              controller: camelCon,
                              onChanged: (value) {
                                selectIndex != camelCon;
                                selectIndex = -1;
                              },
                              prefixIcon: SizedBox(
                                width: 70,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                    const SizedBox(width: 10),
                                    Container(
                                        height: 30,
                                        color: Colors.grey,
                                        width: 2)
                                  ],
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    camelCon.clear();
                                    selectIndex = -1;
                                    selectedDeposit = '';
                                  });
                                },
                                icon: const Icon(Icons.cancel_outlined,
                                    color: AppColors.dividerColor),
                              ),
                            ),
                          ],
                        ),
                      ),
            const SizedBox(height: 20),

            ///button
            AppBtn(
              onTap: () {
                if (!loading) {
                  if (selectedIndex == 0) {
                    addMoney(context, usdtCon.text);
                  } else if (selectedIndex == 1) {
                    indianPay(depositCon.text, context);
                  } else if (selectedIndex == 2) {
                    camelDeposit(camelCon.text, selectedIndex.toString(),context);
                  }
                }
              },
              hideBorder: true,
              title: selectedIndex == 0
                  ? 'USDT Pay Deposit'
                  : selectedIndex == 1
                      ? 'Indian Pay Deposit'
                      : "C2 Payin",
              gradient: AppColors.loginSecondaryGrad,
            ),
            if (loading)
              Center(
                child: Container(
                  height: 45,
                  width: 43,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.whiteColor,
                        AppColors.darkColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              ),

            const SizedBox(
              height: 20,
            ),

            const SizedBox(height: 20),
            Container(
              width: width,
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: AppColors.contSelectColor,
                  borderRadius: BorderRadiusDirectional.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Assets.iconsRecIns,
                        scale: 1.5,
                      ),
                      const SizedBox(width: 15),
                      textWidget(
                          text: 'Recharge instructions',
                          fontSize: 20,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w900),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.contSelectColor,
                        border: Border.all(color: AppColors.whiteColor),
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: invitationRuleList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return instruction(invitationRuleList[index]);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.allRules}3'),
    );
    if (kDebugMode) {
      print('${ApiUrl.allRules}3');
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

  int minimumAmount = 100;

  ///gateway select api
  List<GetwayModel> items = [];

  Future<void> getWaySelect() async {
    final response = await http.get(
      Uri.parse(ApiUrl.getWayList),
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        minimumAmount = json.decode(response.body)['minimum'];
        items = responseData.map((item) => GetwayModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
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

  UserViewModel userProvider = UserViewModel();

  String userStatus = "";

  indianPay(String depositCon, context) async {
    setState(() {
      loading = true;
    });

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(
      Uri.parse(ApiUrl.indianPayDeposit),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "user_id": token,
        "cash": depositCon,
        "type": selectedIndex.toString()
      }),
    );

    final data = jsonDecode(response.body);
    setState(() {
      loading = false;
    });

    if (data["status"] == 'SUCCESS') {
      if (selectedIndex == 0) {
        var qrUrl = data['qrcode_url'].toString();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWeb(url: qrUrl, type: selectedIndex),
          ),
        );
      } else if (selectedIndex == 1) {
        var payUrl = data['payment_link'].toString();
        if (kIsWeb) {
          _launchURL(context, payUrl);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentWeb(url: payUrl, type: selectedIndex),
            ),
          );
        }
      }
    } else {
      Utils.flushBarErrorMessage(data["message"], context, Colors.white);
    }
  }

  addMoney(context, String depositCon) async {
    setState(() {
      addLoading = true;
    });

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(
      Uri.parse(ApiUrl.deposit),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "user_id": token,
        "amount": depositCon,
        "type": selectedIndex.toString()
      }),
    );

    final data = jsonDecode(response.body);
    setState(() {
      addLoading = false;
    });

    if (response.statusCode == 200 && data.containsKey('data')) {
      if (selectedIndex == 0) {
        var qrUrl = data['data']['status_url'].toString();
        kIsWeb
            ? _launchURL(context, qrUrl)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PaymentWeb(url: qrUrl, type: selectedIndex),
                ),
              );
      } else if (selectedIndex == 1) {
        var payUrl = data['data']['payment_link'].toString();
        if (kIsWeb) {
          _launchURL(context, payUrl);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentWeb(url: payUrl, type: selectedIndex),
            ),
          );
        }
      }
      Utils.flushBarSuccessMessage(data["message"], context, Colors.white);
    } else {
      Utils.flushBarErrorMessage(data["message"], context, Colors.white);
    }
  }

  Future<void> camelDeposit(String amount, String type,context) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
      Uri.parse("${ApiUrl.depositCamLenio}$token&amount=$amount&type=$type"),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var qrUrl = data['result']['payment_url'].toString();
      if (kIsWeb) {
        _launchURL(context, qrUrl);
      } else {
        _launchURL(context, qrUrl);
      }
      Utils.flushBarSuccessMessage(data["message"], context, Colors.white);
    } else {
      Utils.flushBarErrorMessage(data["message"], context, Colors.white);
    }
  }

  bool addLoading = false;

  _launchURL(context, String urlGet) async {
    var url = urlGet;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.flushBarErrorMessage(
          "Could not launch $url", context, Colors.white);
      throw 'Could not launch $url';
    }
  }

  paymentStatus(String userStatus, context) async {
    if (kDebugMode) {
      print(ApiUrl.paymentCheckStatus + userStatus);
      print("ApiUrl.paymentCheckStatus+userStatus");
    }

    final response = await http.get(
      Uri.parse(ApiUrl.paymentCheckStatus + userStatus),
    );
    final data = jsonDecode(response.body);
    if (data["status"] == "200") {
      Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
    } else {
      Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
    }
  }
}

class NotFoundData extends StatelessWidget {
  const NotFoundData({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}

Widget instruction(String title) {
  return ListTile(
    leading: Transform.rotate(
      angle: 45 * 3.1415927 / 180,
      child: Container(
        height: 10,
        width: 10,
        color: AppColors.whiteColor,
      ),
    ),
    title: textWidget(text: title, fontSize: 14, color: AppColors.whiteColor),
  );
}

class DepositModel {
  final String value;
  final String title;

  DepositModel({
    required this.value,
    required this.title,
  });
}
