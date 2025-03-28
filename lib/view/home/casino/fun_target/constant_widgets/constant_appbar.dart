import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/view/home/casino/fun_target/Constant/color.dart';
import 'package:game_on/view/home/casino/fun_target/constant_widgets/container_widget.dart';
import 'package:game_on/view/home/casino/fun_target/constant_widgets/small_text_style.dart';
import 'package:game_on/view/home/casino/fun_target/constant_widgets/sub_title_style.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    final userDetails = Provider.of<ProfileViewModel>(context);
    return AppBar(
      centerTitle: false,
      backgroundColor: ColorConstant.darkBlackColor,
      leadingWidth: 120,
      leading: CustomContainer(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -1),
            color: Colors.yellow,
            spreadRadius: 0.5,
            blurRadius: 1,
            blurStyle: BlurStyle.inner,
          )
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
        margin: const EdgeInsets.only(left: 15, top: 12, bottom: 5),
        gradient: const LinearGradient(colors: [
          Colors.yellow,
          Colors.orangeAccent,
          Colors.orange,
          Colors.deepOrangeAccent
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        child: SubTitleText(
          title: "lobby".toUpperCase(),
          fontWeight: FontWeight.bold,
          textColor: ColorConstant.whiteColor,
        ),
      ),
      title: SubTitleText(
        alignment: Alignment.centerLeft,
        title: title,
        textColor: ColorConstant.orangeAccient,
      ),
      actions: [
        Row(
          children: [
            SubTitleText(
              textColor: ColorConstant.whiteColor,
              title: "Welcome, ${userDetails.userName}",
            ),
            const SizedBox(
              width: 10,
            ),
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              gradient: LinearGradient(colors: [
                Colors.grey.shade700,
                Colors.grey.shade700,
                Colors.grey.shade500.withOpacity(0.8),
                Colors.grey.shade700,
                Colors.grey.shade700,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              widths: widthFun / 4,
              height: heightFun / 13,
              border: Border(
                top: BorderSide(
                    width: 1, color: ColorConstant.whiteColor.withOpacity(0.6)),
                bottom: BorderSide(
                    width: 1, color: ColorConstant.whiteColor.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(
                    textColor: ColorConstant.whiteColor,
                    title: "Balance",
                    fontWeight: FontWeight.bold,
                  ),
                  CustomContainer(
                    alignment: Alignment.topCenter,
                    height: heightFun / 18,
                    widths: widthFun / 8,
                    gradient: LinearGradient(colors: [
                      Colors.orange,
                      Colors.orange.shade300,
                      Colors.yellow,
                      Colors.yellowAccent,
                      Colors.yellow,
                      Colors.orange.shade300,
                      Colors.orange,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    child: SmallText(
                      title: userDetails.balance,
                      fontWeight: FontWeight.bold,
                      textColor: ColorConstant.darkBlackColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          width: widthFun / 18,
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              Assets.funTargetCancelButtonFun,
              scale: 3.5,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
