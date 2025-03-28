
import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/home/mini/titli_kabootar/controller/history_controller.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view_model/history_view_model.dart';
import 'package:provider/provider.dart';

class TitliHistoryPage extends StatefulWidget {
  const TitliHistoryPage({super.key});

  @override
  State<TitliHistoryPage> createState() => _TitliHistoryPageState();
}

class _TitliHistoryPageState extends State<TitliHistoryPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final history = Provider.of<HistoryViewModel>(context, listen : false);
      history.historyApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return Consumer<HistoryViewModel>(
      builder: (context, hvm , child) {
        return Material(
          color: Colors.transparent,
         child: Container(
           height: height,
                margin: EdgeInsets.symmetric(horizontal: width*0.03,
                    vertical: height*0.02),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.titliHistory),
                  fit: BoxFit.fill
                  )
                ),
           child: Column(
             children: [
               Container(
                 margin: EdgeInsets.only(left: width*0.025,top: height*0.055),
                 height: height*0.13,
                 width: width*0.22,
                 decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.titliBlackBtn),fit: BoxFit.fill)
                 ),
                 alignment: Alignment.center,
                 child: const TextConst(
                   title: "GAME HISTORY",
                   color: AppColors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                 ),
               ),
               Column(
                 children: [
                   gameHistoryItem(),
                   gameHistoryData(),
                 ],
               ),
               const Spacer(),
               Row(
                 children: [
                   InkWell(
                     onTap: (){
                       final history = Provider.of<HistoryViewModel>(context, listen : false);
                       history.historyApi(context);
                       Utils.flushBarSuccessMessage("Refresh Succesfully", context, AppColors.white);
                     },
                     child: Container(
                       margin: EdgeInsets.only(bottom: height*0.06,left: width*0.05),
                       height: height*0.1,
                       alignment: Alignment.center,
                       width: width*0.14,
                       decoration: const BoxDecoration(
                         image: DecorationImage(image: AssetImage(Assets.titliGreen),
                         fit: BoxFit.fill),
                       ),
                       child: const TextConst(
                         title: "Refresh",
                         fontWeight: FontWeight.bold,
                         fontSize: 18,
                         color: AppColors.white,
                       ),
                     ),
                   ),
                   const Spacer(),
                   InkWell(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child: Container(
                       margin: EdgeInsets.only(bottom: height*0.06,left: width*0.02,right: width*0.05),
                       height: height*0.1,
                       alignment: Alignment.center,
                       width: width*0.12,
                       decoration: const BoxDecoration(
                         image: DecorationImage(image: AssetImage(Assets.titliGreen),
                             fit: BoxFit.fill),
                       ),
                       child: const TextConst(
                         title: "Cancel",
                         fontWeight: FontWeight.bold,
                         fontSize: 18,
                         color: AppColors.white,
                       ),
                     ),
                   ),
                 ],
               )
             ],
           ),
         ),
        );
      }
    );
  }

  Widget gameHistoryItem(){
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return Consumer<HistoryController>(
      builder: (context,hcv,child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: width*0.07,vertical: height*0.05),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.pink
            ),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              hcv.historyItem.length,
                  (index) => SizedBox(
                    width: width*0.1,
                    child: TextConst(
                      title: hcv.historyItem[index],
                     color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
            ),
          ),
        );
      }
    );
  }
  Widget gameHistoryData(){
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return Consumer<HistoryViewModel>(
        builder: (context,hvm,child) {
          return
            hvm.historyModel != null
            ?Container(
            margin: EdgeInsets.symmetric(horizontal: width*0.07),
            child: Column(
              children: [
                SizedBox(
                  height: height*0.4,
                  child: ListView.builder(
                      itemCount: hvm.historyModel!.data!.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, int index){
                        final historyData = hvm.historyModel!.data![index];
                        String numberString = historyData.number.toString();
                        String formattedString = numberString.replaceAll(RegExp(r'[\[\]]'), '');

                    return  Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             title: historyData.gamesNo.toString(),
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 10,
                           ),
                         ),
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             title: formattedString,
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 12,
                           ),
                         ),
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             title: historyData.totalAmount==null ? "0":"🪙${historyData.totalAmount}",
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 12,
                           ),
                         ),
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             title: historyData.winNumber==null ? "0":historyData.winNumber.toString(),
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 12,
                           ),
                         ),
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             title: historyData.winAmount == null?"0":"🪙${historyData.winAmount}",
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 12,
                           ),
                         ),
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             // title: historyData.status == 1 ? "WIN":"LOSS",
                             title: historyData.status == 0
                                 ? "PENDING"
                                 : historyData.status == 1
                                 ? "WIN"
                                 : "LOSS",
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 12,
                           ),
                         ),
                         SizedBox(
                           width: width*0.1,
                           child: TextConst(
                             title: historyData.updatedAt.toString(),
                             color: AppColors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 12,
                           ),
                         ),
                       ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ):
            const Center(child: TextConst(
              title: "No data Available",
              color: AppColors.white,
            ),);
        }
    );
  }

}
