
import 'package:game_on/material_imports.dart';


class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isButtonEnabled;
  final double? width;

  const ActionButton({
    super.key,
    required this.label,
    this.onTap,
    this.isButtonEnabled = true, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ContBox(
      onTap: isButtonEnabled ? onTap : null,
      gradient: LinearGradient(
        colors: isButtonEnabled
            ? [const Color(0xffD4145A), const Color(0xffFBB03B)]
            : [Colors.grey, Colors.grey.shade500],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      height: Sizes.screenWidth / 25,
      width: width??Sizes.screenWidth / 8,
      radius: 5,
      color: Colors.lightBlue,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: CText(
        label,
        size: Sizes.fontSize(7),
        color: Colors.white,
        weight: FontWeight.w600,
      ),
    );
  }
}
