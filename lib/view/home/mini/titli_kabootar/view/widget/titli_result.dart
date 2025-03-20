import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/get_amount_view_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/result_view_model.dart';
import 'package:provider/provider.dart';

class TitliResultScreen extends StatefulWidget {
  const TitliResultScreen({super.key});

  @override
  State<TitliResultScreen> createState() => _TitliResultScreenState();
}

class _TitliResultScreenState extends State<TitliResultScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ResultViewModel>(
      builder: (context, rvm, child) {
        if (rvm.resultModel?.data == null || rvm.resultModel!.data!.isEmpty) {
          return const Center(
            child: Text("No results available", style: TextStyle(color: AppColors.white),),
          );
        }

        final resultData = rvm.resultModel!.data!;

        return Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.06),
                  padding: const EdgeInsets.only(top: 18, bottom: 1),
                  height: height * 0.16,
                  width: width * 0.35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.titliHistoryBg),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: resultData.isNotEmpty
                        ? List.generate(resultData.length > 2 ? resultData.length - 2 : 0, (index) {
                      final reversedIndex = resultData.length - 2 - index;
                      final itemImage = resultData[reversedIndex];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                        width: width * 0.035,
                        decoration: BoxDecoration(
                          image: itemImage.image != null && itemImage.image.isNotEmpty
                              ? DecorationImage(
                            image: NetworkImage(itemImage.image),
                            fit: BoxFit.fill,
                          )
                              : null, // Handle null or empty image case
                        ),
                      );
                    })
                        : [const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )], // Wrap in a list
                  ),


                ),

                // Left Side Image (First Image)
                if (resultData.isNotEmpty && resultData.last.image != null)
                  Positioned(
                    left: width * 0.06 - (width * 0.035),
                    top: height * 0.03,
                    child: Column(
                      children: [
                        const TextConst(
                          title: "OLD",
                          fontSize: 10,
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: width * 0.035,
                          height: height * 0.082,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(rvm.getLastResult!.image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Right Side Image (Last Image)
                if (resultData.length > 1 && resultData.first.image != null)
                  Positioned(
                    right: width * 0.054 - (width * 0.037),
                    top: height * 0.03,
                    child: Column(
                      children: [
                        const TextConst(
                          title: "RECENT",
                          fontSize: 10,
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: width * 0.035,
                          height: height * 0.082,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(rvm.getFirstResult!.image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            TextConst(
              title: "Games No : ${resultData.first.gamesNo + 1}",
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: 9,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  bottom: height * 0.045, left: width * 0.01),
              height: height * 0.12,
              width: width * 0.17,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.titliMinMax),
                      fit: BoxFit.fill)),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width*0.065, top: height*0.03),
                    child: const TextConst(
                      textAlign: TextAlign.center,
                      title: "1",
                      fontSize: 15,
                      color: AppColors.white,

                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:width*0.03, top: height*0.03),
                    child: const TextConst(
                      title: "500",
                      fontSize: 15,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Consumer<GetAmountViewModel>(
              builder: (context,gav,child) {
                return gav.getAmountModel != null?Container(
                  margin: EdgeInsets.only(
                      bottom: height * 0.045, left: width * 0.02),
                  height: height * 0.12,
                  width: width * 0.16,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.titliPlayWinBox),
                          fit: BoxFit.fill)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2 , top: 2),
                        child: TextConst(
                          title: gav.getAmountModel!.data!.totalAmount==null?"0":gav.getAmountModel!.data!.totalAmount.toString(),
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2 , top: 2),
                        child: TextConst(
                          title: gav.getAmountModel!.data!.winAmount==null?"0":gav.getAmountModel!.data!.winAmount.toString(),
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ):Container(
                  margin: EdgeInsets.only(
                      bottom: height * 0.045, left: width * 0.02),
                  height: height * 0.12,
                  width: width * 0.16,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.titliPlayWinBox),
                          fit: BoxFit.fill)),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2 , top: 2),
                        child: TextConst(
                          title: "0",
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2 , top: 2),
                        child: TextConst(
                          title: "0",
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //       bottom: height * 0.045, left: width * 0.02),
            //   height: height * 0.12,
            //   width: width * 0.16,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage(Assets.titliPlayWin),
            //           fit: BoxFit.fill)),
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 2 , top: 2),
            //         child: TextConst(
            //           title: tc.addTitliBets.length.toString(),
            //           // title: gav.getAmountModel!.data!.totalAmount.toString(),
            //           color: AppColors.white,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 2 , top: 2),
            //         child: TextConst(
            //           title: resultData.first.multiplier == null? "0": resultData.first.multiplier.toString(),
            //           // title: gav.getAmountModel!.data!.winAmount.toString(),
            //           color: AppColors.white,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        );
      },
    );
  }
}
