import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/deposit_view_model.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final accountView = Provider.of<DepositViewModel>(context, listen: false);
      accountView.accountViewApi(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final accountView = Provider.of<DepositViewModel>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width*0.14, vertical: height*0.1),
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.imagesBlackHisBox),fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              spaceHeight15,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width*0.2,
                  ),
                  const Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: width*0.15,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Align(
                        alignment: Alignment.centerRight,
                        child: Image(
                            height: 20,
                            image: AssetImage(Assets.titliCancel))
                    ),
                  ),
                  spaceWidth10,
                ],
              ),
              spaceHeight15,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.1),
                child: Divider(
                  color: AppColors.white,
                  height: height * 0.001,
                ),
              ),
              spaceHeight15,
              Expanded(
                child: Container(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.02),
                  child: accountView.accountViewModel != null
                  ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: accountView.accountViewModel!.data!.length,
                    itemBuilder: (context, index) {
                      final data = accountView.accountViewModel!.data![index];
                      return Container(
                        width: width*0.42,
                        margin: const EdgeInsets.all(5),
                        padding: EdgeInsets.only(top: height*0.02, left: width*0.02,),
                        decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage(Assets.titliHistory), fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            spaceHeight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    width : width*0.2,
                                    child: const TextConst(
                                      textAlign: TextAlign.start,
                                      title: "Holder Name :", fontSize: 12,color: AppColors.white,)),
                                SizedBox(
                                    width : width*0.2,
                                    child: TextConst(
                                      textAlign: TextAlign.start,
                                      title: data.name, fontSize: 12, color: AppColors.white,))
                              ],
                            ),
                            spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width : width*0.2,
                                  child: const TextConst(
                                    textAlign: TextAlign.start,
                                    title: "Bank Name:", fontSize: 12,  color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title: data.bankName, fontSize: 12,  color: AppColors.white,),
                                )
                              ],
                            ),
                            spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width : width*0.2,
                                  child: const TextConst(
                                    textAlign: TextAlign.start,
                                    title: "Account Number :", fontSize: 12, color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title: data.accountNumber,
                                    color: AppColors.white ,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width : width*0.2,
                                  child: const TextConst(
                                    textAlign: TextAlign.start,
                                    title: "IFSC Code :", fontSize: 12, color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title: data.ifscCode, fontSize: 12, color: AppColors.white,),
                                )
                              ],
                            ),
                            spaceHeight5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width : width*0.2,
                                  child: const TextConst(
                                    textAlign: TextAlign.start,
                                    title: "Upi Id :", fontSize: 12, color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title: data.upi, fontSize: 12, color: AppColors.white,),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      :const TextConst(title: "No Account Added", color: AppColors.white,)
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


}