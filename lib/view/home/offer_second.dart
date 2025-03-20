import 'dart:convert';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/extradepositmodel.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/offer/offer_view_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/view/wallet/deposit_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:globalbet/view/wallet/first_deposit_bonus_list.dart';
import 'package:provider/provider.dart';

class OfferSecond extends StatefulWidget {
  const OfferSecond({super.key});

  @override
  State<OfferSecond> createState() => _OfferSecondState();
}

class _OfferSecondState extends State<OfferSecond> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_){
      final offer = Provider.of<OfferViewModel>(context, listen: false);
      offer.offerApi(context);
    });
    super.initState();
  }

  bool loading = false;

  int? responseStatuscode;
  bool readAndAgreePolicy = false;

  @override
  Widget build(BuildContext context) {
    final offer = Provider.of<OfferViewModel>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: height * 0.75,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.5,
              decoration: BoxDecoration(
                  gradient: AppColors.loginSecondryGrad,
                  borderRadius: BorderRadius.circular(15)),
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Text(
                    'NOTICE',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                      height: height * 0.4,
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryUnselectedGradient,
                      ),
                      child:
                      offer.OfferModelData != null?
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: offer.OfferModelData!.data!.length,
                          itemBuilder: (context, index) {
                            final data= offer.OfferModelData!.data![index];
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                  color: AppColors.FirstColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(data.image.toString() ?? ""))
                                        ),
                                      ),
                                      SizedBox(
                                        width: width*0.5,
                                        child: textWidget(
                                            text: data.title.toString(),
                                            color: Colors.white,
                                            fontSize: 15,
                                            maxLines: 3,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  textWidget(
                                      text: data.content.toString(),
                                      color: AppColors.constColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            );
                          })
                  :Center(child: CircularProgressIndicator(),)
                  )

                ],
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.primaryTextColor,
                  size: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
