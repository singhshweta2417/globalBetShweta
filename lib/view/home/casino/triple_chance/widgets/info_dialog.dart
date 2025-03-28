import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';

class InfoDialog extends StatefulWidget {
  final String? title;
  final String? content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final double? width;
  final double? height;
  final DecorationImage image;

  const InfoDialog({
    super.key,
    this.title,
    this.content,
    this.onConfirm,
    this.onCancel,
    this.width,
    this.height,
    required this.image,
  });

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  String selectedType = 'history';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: height * 0.75,
        width: width * 0.95,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(image: widget.image),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 'history';
                    });
                  },
                  child: Container(
                    height: height * 0.10,
                    width: width * 0.15,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.tripleChanceGBtnBg),
                            fit: BoxFit.fill)),
                    child: const Text(
                      'HISTORY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff174414)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 'payout';
                    });
                  },
                  child: Container(
                    height: height * 0.10,
                    width: width * 0.15,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.tripleChanceGBtnBg),
                            fit: BoxFit.fill)),
                    child: const Text(
                      'PAYOUT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff174414)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 'rules';
                    });
                  },
                  child: Container(
                    height: height * 0.10,
                    width: width * 0.15,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.tripleChanceGBtnBg),
                            fit: BoxFit.fill)),
                    child: const Text(
                      'RULES',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff174414)),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: height * 0.47,
              width: width * 0.85,
              child: selectedType == 'history'
                  ? historyData()
                  : selectedType == 'payout'
                      ? payoutData()
                      : selectedType == 'rules'
                          ? const TripleChanceRule()
                          : const SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.10,
                width: width * 0.15,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.tripleChanceGBtnBg),
                      fit: BoxFit.fill),
                ),
                child: const Text(
                  'CLOSE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff174414)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyData() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'No Data Available!',
          style:
              TextStyle(color: Color(0xffb1650d), fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget payoutData() {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Game Play Payout',
              style: TextStyle(
                  color: Color(0xfff8e392),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'roboto_lite'),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: Table(
                    border: TableBorder.all(color: const Color(0xff9b5f17)),
                    columnWidths: {
                      0: FixedColumnWidth(
                          width * 0.1), // Adjust the width as needed
                      1: FixedColumnWidth(width * 0.13),
                      2: FixedColumnWidth(
                          width * 0.0005), // Adjust the width as needed
                    },
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            'Point',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color(0xffe6d489),
                                fontSize: width * 0.018,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto_lite'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text('Wheel',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: const Color(0xffe6d489),
                                  fontSize: width * 0.018,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto_lite')),
                        ),
                        Text('Payout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color(0xffe6d489),
                                fontSize: width * 0.018,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto_lite')),
                      ]),
                      tableData('Play 10 Chips on a Single number',
                          'Singles play/Inner wheel play', '90',context),
                      tableData('Play 10 Chips on a Single number',
                          'Doubles play/Middle wheel play', '900',context),
                      tableData('Play 10 Chips on a Single number',
                          'Triples play/Outer wheel play', '9000',context),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Pay Limit',
              style: TextStyle(
                  color: Color(0xfff8e392),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'roboto_lite'),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: Table(
                    border: TableBorder.all(color: const Color(0xff9b5f17)),
                    columnWidths: {
                      0: FixedColumnWidth(
                          width * 0.1), // Adjust the width as needed
                      1: FixedColumnWidth(width * 0.13),
                      2: FixedColumnWidth(
                          width * 0.0005), // Adjust the width as needed
                    },
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            'Play',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color(0xffe6d489),
                                fontSize: width * 0.018,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto_lite'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text('Minimum Play',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: const Color(0xffe6d489),
                                  fontSize: width * 0.018,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto_lite')),
                        ),
                        Text('Maximum Play',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color(0xffe6d489),
                                fontSize: width * 0.018,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto_lite')),
                      ]),
                      tableData('Singles Play', '2', '10000',context),
                      tableData('Doubles Play', '2', '1000',context),
                      tableData('Triples Play', '2', '100',context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

TableRow tableData(String value, String wheel, String payout,context) {
  final width = MediaQuery.of(context).size.width;
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(value,
          style: TextStyle(
              color: const Color(0xfff8e392),
              fontSize: width * 0.017,
              fontFamily: 'roboto_lite')),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(wheel,
          style: TextStyle(
              color: const Color(0xfff8e392),
              fontSize: width * 0.017,
              fontFamily: 'roboto_lite')),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(payout,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: const Color(0xfff8e392),
              fontSize: width * 0.017,
              fontFamily: 'roboto_lite')),
    ),
  ]);
}


class TripleChanceRule extends StatelessWidget {
  const TripleChanceRule({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Game Play Rules',
              style: TextStyle(
                  color: Color(0xffd1bc79),
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Triple Chance is a very simple wheel game; there are 3 wheels namely the outer wheel, middle wheel and inner wheel.',
              style: TextStyle(
                  color: Color(0xffd1bc79),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Each wheel has numbers 0-9 randomly placed at equal intervals. In every game the 3 wheels are rotated in opposite direction\nand when all the wheels come to halt the result is displayed and the payout is calculated.',
              style: TextStyle(
                  color: Color(0xffd1bc79),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: height * 0.5,
                  width: width * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.tripleChanceRulesBg),
                        fit: BoxFit.fill),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'User can place his points on any wheel, the inner wheel play is called singles play, the middle wheel play is called doubles\nplay and the outer is called triples play.',
              style: TextStyle(
                  color: Color(0xffd1bc79),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Singles play can be placed between 0-9\nDoubles play can be placed between 00-99\nTriples play can be placed between 000-999',
              style: TextStyle(
                  color: Color(0xffd1bc79),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
