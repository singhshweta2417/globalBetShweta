import 'dart:async';
import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/color.dart';
import 'package:globalbet/view/home/casino/fun_target/constant_widgets/container_widget.dart';
import 'package:globalbet/view/home/casino/fun_target/constant_widgets/small_text_style.dart';

class BlinkingStar extends StatefulWidget {
  const BlinkingStar({super.key});

  @override
  BlinkingStarState createState() => BlinkingStarState();
}

class BlinkingStarState extends State<BlinkingStar> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: isVisible ? 0.8 : 0.0,
        child: Image.asset(
          Assets.funTargetTwin,
          width: 30,
          fit: BoxFit.cover,
        ));
  }
}

class BlinkingTimerBg extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isTimeToStartBlinking;
  final Widget? child;
  const BlinkingTimerBg({
    Key? key,
    this.width,
    this.height,
    this.isTimeToStartBlinking = false,
    this.child,
  }) : super(key: key);

  @override
  State<BlinkingTimerBg> createState() => _BlinkingTimerBgState();
}

class _BlinkingTimerBgState extends State<BlinkingTimerBg> {
  bool isBlinking = false;
  late Timer _blinkTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isTimeToStartBlinking) {
      startBlinking();
    }
  }

  @override
  void didUpdateWidget(covariant BlinkingTimerBg oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isTimeToStartBlinking != widget.isTimeToStartBlinking) {
      if (widget.isTimeToStartBlinking) {
        startBlinking();
      } else {
        stopBlinking();
      }
    }
  }

  void startBlinking() {
    _blinkTimer = Timer.periodic(const Duration(microseconds: 200), (timer) {
      setState(() {
        isBlinking = !isBlinking;
      });
    });
  }

  void stopBlinking() {
    _blinkTimer.cancel();
    setState(() {
      isBlinking = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: isBlinking ? 0.8 : 0.0,
      child: CustomContainer(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.only(left: 8, top: 12),
        borderRadius: BorderRadius.circular(15),
        widths: widget.width ?? widthFun / 5.6,
        height: widget.height ?? heightFun / 11,
        gradient: const LinearGradient(
          colors: [
            Colors.deepOrange,
            Colors.orange,
            Colors.yellow,
            Colors.deepOrange,
            Colors.orange
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }
}

class BlinkingTakeOption extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isTimeToStartBlinking;
  final String isSide;
  const BlinkingTakeOption({
    Key? key,
    this.width,
    this.height,
    this.isTimeToStartBlinking = false,
    required this.isSide,
  }) : super(key: key);

  @override
  State<BlinkingTakeOption> createState() => _BlinkingTakeOptionState();
}

class _BlinkingTakeOptionState extends State<BlinkingTakeOption> {
  bool isBlinking = false;
  late Timer _blinkTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isTimeToStartBlinking) {
      startBlinking();
    }
  }

  @override
  void didUpdateWidget(covariant BlinkingTakeOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isTimeToStartBlinking != widget.isTimeToStartBlinking) {
      if (widget.isTimeToStartBlinking) {
        startBlinking();
      } else {
        stopBlinking();
      }
    }
  }

  void startBlinking() {
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        isBlinking = !isBlinking;
      });
    });
  }

  void stopBlinking() {
    _blinkTimer.cancel();
    setState(() {
      isBlinking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return !isBlinking
        ? CustomContainer(
            widths: width / 10,
            height: height / 11,
            image: DecorationImage(
                image: widget.isSide == "left"
                    ? const AssetImage(Assets.funTargetLeftTake)
                    : const AssetImage(Assets.funTargetBetOkRight),
                fit: BoxFit.fitWidth),
            child: SmallText(
              fontWeight: FontWeight.bold,
              fontSize: width / 65,
              title: widget.isSide == "left" ? "Take" : "Bet Ok",
              textColor: ColorConstant.whiteColor,
            ),
          )
        : CustomContainer(
            widths: width / 10,
            margin: EdgeInsets.only(bottom: widget.isSide == "left" ? 0 : 0),
            height: height / 19,
            borderRadius: widget.isSide == "left"
                ? const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
            gradient: const RadialGradient(
                colors: [Colors.orange, Colors.orangeAccent, Colors.orange]),
            child: SmallText(
              fontWeight: FontWeight.bold,
              fontSize: width / 65,
              title: widget.isSide == "left" ? "Take" : "Bet Ok",
              textColor: ColorConstant.whiteColor,
            ),
          );
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }
}

class BlinkingWinnerNumber extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isTimeToStartBlinking;
  final Widget child;
  final String index;
  const BlinkingWinnerNumber({
    Key? key,
    this.width,
    this.height,
    this.isTimeToStartBlinking = false,
    required this.child,
    required this.index,
  }) : super(key: key);

  @override
  State<BlinkingWinnerNumber> createState() => _BlinkingWinnerNumberState();
}

class _BlinkingWinnerNumberState extends State<BlinkingWinnerNumber> {
  bool isBlinking = false;
  late Timer _blinkTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isTimeToStartBlinking) {
      startBlinking();
    }
  }

  @override
  void didUpdateWidget(covariant BlinkingWinnerNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isTimeToStartBlinking != widget.isTimeToStartBlinking) {
      if (widget.isTimeToStartBlinking) {
        startBlinking();
      } else {
        stopBlinking();
      }
    }
  }

  void startBlinking() {
    _blinkTimer = Timer.periodic(const Duration(microseconds: 100), (timer) {
      setState(() {
        isBlinking = !isBlinking;
      });
    });
  }

  void stopBlinking() {
    _blinkTimer.cancel();
    setState(() {
      isBlinking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return !isBlinking
        ? widget.child
        : Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.green,
                  Colors.lightGreen,
                  Colors.green,
                  Colors.greenAccent,
                  Colors.lightGreen
                ])),
            child: SmallText(
              alignment: Alignment.center,
              title: widget.index,
              fontSize: width / 60,
              fontWeight: FontWeight.bold,
            ),
          );
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }
}

class BlinkingCancelRepeat extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isTimeToStartBlinking;
  final String isSide;
  final String title;
  const BlinkingCancelRepeat({
    Key? key,
    this.width,
    this.height,
    this.isTimeToStartBlinking = false,
    required this.isSide,
    required this.title,
  }) : super(key: key);

  @override
  State<BlinkingCancelRepeat> createState() => _BlinkingCancelRepeatState();
}

class _BlinkingCancelRepeatState extends State<BlinkingCancelRepeat> {
  bool isBlinking = false;
  late Timer _blinkTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isTimeToStartBlinking) {
      startBlinking();
    }
  }

  @override
  void didUpdateWidget(covariant BlinkingCancelRepeat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isTimeToStartBlinking != widget.isTimeToStartBlinking) {
      if (widget.isTimeToStartBlinking) {
        startBlinking();
      } else {
        stopBlinking();
      }
    }
  }

  void startBlinking() {
    _blinkTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        isBlinking = !isBlinking;
      });
    });
  }

  void stopBlinking() {
    _blinkTimer.cancel();
    setState(() {
      isBlinking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return !isBlinking
        ? CustomContainer(
            widths: width / 10,
            height: height / 11,
            image: const DecorationImage(
                image: AssetImage(Assets.funTargetCancelBet), fit: BoxFit.fitWidth),
            child: SmallText(
              fontWeight: FontWeight.bold,
              fontSize: width / 75,
              title: widget.title,
              textColor: ColorConstant.whiteColor,
            ),
          )
        : CustomContainer(
            widths: width / 10,
            margin: EdgeInsets.only(bottom: widget.isSide == "left" ? 0 : 0),
            height: height / 24,
            borderRadius: BorderRadius.circular(15),
            gradient: const RadialGradient(
                colors: [Colors.orange, Colors.orangeAccent, Colors.orange]),
            child: SmallText(
              fontWeight: FontWeight.bold,
              fontSize: width / 75,
              title: widget.title,
              textColor: ColorConstant.whiteColor,
            ),
          );
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }
}
