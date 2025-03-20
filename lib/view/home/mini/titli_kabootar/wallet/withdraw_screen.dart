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
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/add_account.dart';
import 'package:provider/provider.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController amount = TextEditingController();

  bool isAmountFilled = false;
  String? _selectedAccount;


  @override
  void initState() {
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((_){
     final accountView = Provider.of<DepositViewModel>(context, listen: false);
     accountView.accountViewApi(context);
     amount.addListener(() {
       setState(() {
         isAmountFilled = amount.text.isNotEmpty;
       });
     });
   });
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final depositViewModel = Provider.of<DepositViewModel>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: width*0.2, vertical: height*0.14),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.imagesBlackHisBox),
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
                    margin: EdgeInsets.only(top: height*0.04, right: 5),
                    height: height*0.05,
                    width: width*0.054,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Assets.titliCancel))
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: width*0.15, top: height*0.001, right: width*0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextConst(
                    title: "Withdraw Amount",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  Divider(
                    color: AppColors.white,
                    thickness: 0.5,
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width*0.1, top: height*0.01),
              child: TextConst(
                title: "Amount",
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 15,
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.01),
              child: CustomTextField(
                  title: "Enter Amount",
                  keyboardType: TextInputType.number,
                  controller: amount,
                  icon: Icon(Icons.currency_rupee, size: 13,)
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width*0.1),
              child: TextConst(
                title: "Select Account",
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 15,
              ),
            ),

        Padding(
          padding: EdgeInsets.only(left: width * 0.1, top: height * 0.02),
          child: Container(
            height: height * 0.08,
            width: width*0.34,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: Colors.green.withAlpha((244 * 0.2).toInt())),
              color: AppColors.black,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButton<String>(
              value: _selectedAccount,
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextConst(
                  title: "Select Account",
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              dropdownColor: Colors.black,
              icon: Padding(
                padding: EdgeInsets.only(left: width * 0.2),
                child: Icon(Icons.arrow_drop_down, color: Colors.grey),
              ),
              underline: Container(),
              items: depositViewModel.accountViewModel?.data?.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.id?.toString(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextConst(
                      title: value.bankName?.toString() ?? "Unknown Bank",
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList() ?? [],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAccount = newValue;
                });
                print(newValue);
              },
            ),
          ),
        ),

        spaceHeight25,
            Center(
              child:
              depositViewModel.accountViewModel != null
              ?AppBtn(
                loading: depositViewModel.addAccountLoading,
                label: "Withdraw",
                height: height*0.08,
                width: width*0.15,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color:  isAmountFilled ? AppColors.green : AppColors.red,
                onTap: () {
                  if(amount.text.isEmpty ){
                    Utils.flushBarErrorMessage("Enter Amount", context, Colors.black);
                  }else{
                    depositViewModel.withdrawApi(_selectedAccount.toString(), amount.text,depositViewModel.accountViewModel!.data!.first.upi ?? 0, context);
                  }
                },
              )
                  : AppBtn(
                loading: depositViewModel.addAccountLoading,
                label: "Add Bank Account",
                height: height*0.08,
                width: width*0.15,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color:  isAmountFilled ? AppColors.green : AppColors.red,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>  AddAccountScreen());
                },
              )
            ),

          ],
        ),
      ),
    );
  }
}
