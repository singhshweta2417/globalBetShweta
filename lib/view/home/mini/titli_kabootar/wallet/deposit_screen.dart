import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_button.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/custom_textfield.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/deposit_view_model.dart';
import 'package:provider/provider.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController amountCon = TextEditingController();

  bool isAmountFilled = false;

  @override
  void initState() {
    super.initState();
    amountCon.addListener(() {
      setState(() {
        isAmountFilled = amountCon.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    amountCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final depositViewModel = Provider.of<DepositViewModel>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: width*0.25,
            vertical: height*0.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(image: AssetImage(Assets.imagesBlackHisBox),
                fit: BoxFit.fill
            ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height*0.05, right: 5),
                    height: height*0.06,
                    width: width*0.06,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.titliCancel))
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: width*0.15, top: height*0.01, right: width*0.15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextConst(
                    title: "Deposit Amount",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  Divider(
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width*0.1, top: height*0.05),
              child: const TextConst(
                title: "Amount",
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 15,
              ),
            ),
            spaceHeight5,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.1),
              child: CustomTextField(
                  keyboardType: TextInputType.number,
                  title: "Enter your Amount",
                  controller: amountCon,
                  icon: const Icon(Icons.currency_rupee, size: 15,),
              ),
            ),
            spaceHeight25,
            Center(
              child: AppBtn(
                height: height*0.08,
                width: width*0.15,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isAmountFilled ? AppColors.green : AppColors.red,
                label: "Deposit",
                onTap: () {
                  if(amountCon.text.isEmpty ){
                    Utils.flushBarErrorMessage("Enter Amount", context, Colors.black);
                  }else{
                    depositViewModel.userPayinApi(amountCon.text, context);
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
