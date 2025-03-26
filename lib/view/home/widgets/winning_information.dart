import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/home/widgets/earning_chart.dart';
import 'package:globalbet/view/home/widgets/home_page_bottom.dart';

// Define your assets here (example)

class WinningInformation extends StatefulWidget {
  const WinningInformation({super.key});

  @override
  _WinningInformationState createState() => _WinningInformationState();
}

class _WinningInformationState extends State<WinningInformation> {
  late List<Map<String, dynamic>> dragonTigerList = [
    {
      "user": "mdw**e764",
      "image": Assets.person1,
      "border": '₹ 200.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "wde**fr44",
      "image": Assets.person2,
      "border": '₹ 243.12',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "cfs*23ww",
      "image": Assets.person3,
      "border": '₹ 126.00',
      'centering': Assets.categoryTrxCoin1
    },
    {
      "user": "hde**fr465",
      "image": Assets.person4,
      "border": '₹ 400.00',
      'centering': Assets.categoryTrxCoin1
    },
    {
      "user": "wee**fr4",
      "image": Assets.person5,
      "border": '₹ 180.00',
      'centering': Assets.categoryWingoCoin1
    },
  ];
  final List<Map<String, dynamic>> possibleFirstElements = [
    {
      "user": "mdw**e764",
      "image": Assets.person1,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryTrxCoin1
    },
    {
      "user": "wde**fr44",
      "image": Assets.person2,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "cfs*23ww",
      "image": Assets.person3,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "hde**fr465",
      "image": Assets.person4,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFivesCoin
    },
    {
      "user": "wee**fr4",
      "image": Assets.person5,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFivesCoin
    },
    {
      "user": "aas**rr12",
      "image": Assets.personPerson6,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "bss**rr13",
      "image": Assets.personPerson7,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "css**rr14",
      "image": Assets.personPerson8,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "dss**rr15",
      "image": Assets.personPerson9,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "ess**rr16",
      "image": Assets.personPerson10,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "fss**rr17",
      "image": Assets.personPerson11,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFivesCoin
    },
    {
      "user": "gss**rr18",
      "image": Assets.personPerson12,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryWingoCoin1
    },
    {
      "user": "hss**rr19",
      "image": Assets.personPerson13,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFlashIcon
    },
    {
      "user": "iss**rr20",
      "image": Assets.personPerson14,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFivesCoin
    },
    {
      "user": "jss**rr21",
      "image": Assets.personPerson15,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFlashIcon
    },
    {
      "user": "kss**rr22",
      "image": Assets.personPerson16,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFivesCoin
    },
    {
      "user": "lss**rr23",
      "image": Assets.personPerson17,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFlashIcon
    },
    {
      "user": "mss**rr24",
      "image": Assets.personPerson18,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFivesCoin
    },
    {
      "user": "nss**rr25",
      "image": Assets.personPerson19,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFlashIcon
    },
    {
      "user": "oss**rr26",
      "image": Assets.personPerson20,
      "border": '₹ ${Random().nextInt(491) * 10}.00',
      'centering': Assets.categoryFlashIcon
    },
  ];

  Timer? _timer;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _initializeList();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeList() {
    // Randomly select 5 items from possibleFirstElements initially
    possibleFirstElements.shuffle();

    // Add 5 more random items from possibleFirstElements
    final random = Random();
    for (int i = 0; i < 5; i++) {
      final randomIndex = random.nextInt(possibleFirstElements.length);
      dragonTigerList.add(possibleFirstElements[randomIndex]);
    }
  }

  void _startTimer() {
    const duration = Duration(seconds: 5);
    _timer = Timer(duration, () {
      try {
        setState(() {
          _updateList();
        });
      } catch (e, stackTrace) {
        if (kDebugMode) {
          print('Error in timer callback: $e\nStack trace: $stackTrace');
        }
      } finally {
        _startTimer(); // Start the timer again for the next iteration
      }
    });
  }

  void _updateList() {
    // Add a new random item from possibleFirstElements
    final newItem = possibleFirstElements
        .firstWhere((item) => !dragonTigerList.contains(item));
    dragonTigerList.add(newItem);

    // Limit dragonTigerList to have only 5 items
    if (dragonTigerList.length > 5) {
      dragonTigerList.removeAt(0); // Remove the oldest item
    }

    // Animate the removal and insertion
    _listKey.currentState!.removeItem(
      0,
      (context, animation) => _buildItem(dragonTigerList[0], animation),
      duration: const Duration(milliseconds: 300),
    );

    _listKey.currentState!
        .insertItem(4, duration: const Duration(milliseconds: 300));
  }

  Widget _buildItem(Map<String, dynamic> item, Animation<double> animation) {
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Container(
            height: height * 0.09,
            width: width,
            decoration: BoxDecoration(
              gradient: AppColors.loginSecondaryGrad,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(item['image']),
                      ),
                      textWidget(
                          text: item['user'],
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.07,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppColors.contGrad),
                  child: Image.asset(item['centering']),
                ),
                SizedBox(
                  width: width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textWidget(
                          text: "Receive  " + item['border'],
                          fontSize: 14,
                          color: AppColors.primaryContColor,
                          fontWeight: FontWeight.w900),
                      textWidget(
                          text: 'Winning amount',
                          fontSize: 13,
                          color: AppColors.unSelectColor,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          children: [
            SizedBox(
                height: height * 0.05,
                width: width * 0.05,
                child: const VerticalDivider(
                  thickness: 3,
                  color: AppColors.primaryContColor,
                )),
            const Text(
              " Winning Information",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
        SizedBox(
          height: height * 0.52,
          child: AnimatedList(
            physics: const NeverScrollableScrollPhysics(),
            key: _listKey,
            initialItemCount:
                dragonTigerList.length > 5 ? 5 : dragonTigerList.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(dragonTigerList[index], animation);
            },
          ),
        ),
        Row(
          children: [
            SizedBox(
                height: height * 0.05,
                width: width * 0.05,
                child: const VerticalDivider(
                  thickness: 3,
                  color: AppColors.primaryContColor,
                )),
            const Text(
              " Today's earnings chart",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
        const EarningChart(),
        const HomePageBottom()
      ],
    );
  }
}
