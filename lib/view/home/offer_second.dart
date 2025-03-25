import 'package:globalbet/main.dart';
import 'package:globalbet/offer/offer_view_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:flutter/material.dart';
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
                  gradient: AppColors.loginSecondaryGrad,
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
                        gradient: AppColors.bgGrad,
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
                                  gradient: AppColors.unSelectedColor,
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
                                            image: DecorationImage(image: NetworkImage(data.image.toString()))
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
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  textWidget(
                                      text: data.content.toString(),
                                      color: AppColors.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            );
                          })
                  :const Center(child: CircularProgressIndicator(),)
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
                  color: AppColors.whiteColor,
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
