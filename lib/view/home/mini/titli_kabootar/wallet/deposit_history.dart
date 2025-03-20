import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/history_view_model.dart';
import 'package:provider/provider.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({super.key});

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final depositHistory = Provider.of<HistoryViewModel>(context, listen: false);
      depositHistory.depositHistoryApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<HistoryViewModel>(
      builder: (context, hvm , child) {
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width*0.2, vertical: height*0.2),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.imagesBlackHisBox),fit: BoxFit.fill),
          ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextConst(
                      title: "Deposit History",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                  ],
                ),
                spaceHeight25,
                Expanded(
                  child:
                  hvm.depositHistoryModel != null
                  ?SizedBox(
                    height: height*0.1,
                    child: ListView.builder(
                        itemCount: hvm.depositHistoryModel!.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          final historyData = hvm.depositHistoryModel!.data![index];

                      return Container(
                        width: width*0.45,
                        margin: const EdgeInsets.all(5),
                        padding: EdgeInsets.only(top: height*0.05, left: width*0.02),
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
                                      title: "Order Id :", fontSize: 12,color: AppColors.white,)),
                                SizedBox(
                                    width : width*0.2,
                                    child: TextConst(
                                      textAlign: TextAlign.start,
                                      title: historyData.orderId, fontSize: 12, color: AppColors.white,))
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
                                    title: "Deposit Amount:", fontSize: 12,  color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title:" ₹${historyData.cash}", fontSize: 12,  color: AppColors.white,),
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
                                    title: "Status :", fontSize: 12, color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title: historyData.status == 1 ? "Pending" : historyData.status == 2 ? "Success":"Reject",
                                    color:historyData.status == 1 ? Colors.orange : historyData.status == 2 ? Colors.green:AppColors.red ,
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
                                    title: "DateTime :", fontSize: 12, color: AppColors.white,),
                                ),
                                SizedBox(
                                  width : width*0.2,
                                  child: TextConst(
                                    textAlign: TextAlign.start,
                                    title: historyData.createdAt, fontSize: 12, color: AppColors.white,),
                                )
                              ],
                            ),
                          ],
                        ),
                      );

                    }),
                  ):
                      const TextConst(title: "No Data Found",
                      color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
