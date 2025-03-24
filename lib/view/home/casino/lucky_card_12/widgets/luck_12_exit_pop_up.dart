import 'package:flutter/material.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';


class Luck12ExitPopUp extends StatelessWidget {
  final VoidCallback yes;
  const Luck12ExitPopUp({
    super.key,
    required this.yes,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: height * 0.3,
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.white)),
          child: Column(
            children: [
              Container(
                height: height * 0.2,
                width: width * 0.3,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.black,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Confirmation',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConstant.spinCoinFont,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w900)),
                    Text('Are you sure you want quit this game?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConstant.luckyRoFont,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: width * 0.3,
                  color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: yes,
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.13,
                          height: height * 0.07,
                          color: Colors.white,
                          child:  Text('Yes',style: TextStyle(fontSize: AppConstant.luckyRoFont)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: width * 0.13,
                          height: height * 0.07,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Text('No',style: TextStyle(fontSize: AppConstant.luckyRoFont)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

Widget textWidget({
  required String text,
  double? fontSize,
  String? fontFamily,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      fontFamily: fontFamily??'roboto',
      fontSize: fontSize??12,
      fontWeight: fontWeight,
      color:  color,
    ),
  );
}