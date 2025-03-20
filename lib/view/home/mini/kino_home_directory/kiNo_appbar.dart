import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/provider/profile_provider.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_bool_provider.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/hello_how_to_play.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/kino_colors.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/kino_menu_bar.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:provider/provider.dart';


class KiNoAppbar extends StatefulWidget {
  final KiNoBoolProvider betPlaced;
  const KiNoAppbar({super.key, required this.betPlaced});

  @override
  State<KiNoAppbar> createState() => _KiNoAppbarState();
}

class _KiNoAppbarState extends State<KiNoAppbar> {
  @override
  Widget build(BuildContext context) {
    final userProfileViewModel = Provider.of<ProfileProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height*0.05,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black26),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Container(
                height: height*0.035,
                width: width*0.235,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.black),
                    gradient: KiNoColors.kiNoBtn
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // widget.betPlaced.disConnectToServer(context);
                          Navigator.pop(context);
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.white,
                        )),
                    const Text(
                      'KINO',
                      style: TextStyle(
                          color: Colors.white,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width*0.027,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return const HiloHowToPlay();
                    },
                  );
                },
                child: Container(
                  height: height*0.035,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 0.5, color: Colors.black),
                      gradient: KiNoColors.kiNoBtn
                  ),
                  child: const Icon(
                    Icons.help_outline_rounded,
                    size: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.currency_rupee_outlined,
                      size: 20, color: AppColors.white),
                  textWidget(
                    text: userProfileViewModel.totalWallet.toString(),
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // userProfileViewModel.userProfileApi(context);
                      Utils.flushBarSuccessMessage('Wallet refresh ✔', context,Colors.green);

                    },
                    child: Image.asset(Assets.imagesReload, height: 30,),
                  ),
                ],
              ),
              InkWell(
                onTap: () => showSideMenu(context),
                child: Container(
                    height: height*0.035,
                    width: width*0.07,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 0.5, color: Colors.black),
                        gradient: KiNoColors.kiNoBtn
                    ),
                    child:  const Icon(
                      Icons.menu,
                      size: 15,
                      color: Colors.white,
                    )

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void showSideMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const KinoMenuBar();
      },
    );
  }
}
