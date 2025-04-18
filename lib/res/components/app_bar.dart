import 'package:flutter/material.dart';
import 'package:game_on/res/aap_colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Gradient? gradient;

  const GradientAppBar({
    Key? key,
    this.leading,
    required this.title,
    this.centerTitle,
    this.actions,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.loginSecondaryGrad),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: leading,
        title: title,
        actions: actions,
        centerTitle: centerTitle ?? false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
