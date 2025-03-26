import 'dart:math';
import 'package:flutter/material.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/SharedPreference.dart';

class WheelSpinController {
  late void Function() startWheel;
  late void Function(int index) stopWheel;
  int targetNumber = 0;
}

class WheelSpin extends StatefulWidget {
  final WheelSpinController controller;
  final String pathImage;
  final double withWheel;
  final int pieces;
  final double offset;
  final bool isShowTextTest;
  final int speed;

  const WheelSpin({
    Key? key,
    required this.controller,
    required this.pathImage,
    required this.withWheel,
    this.offset = 0,
    required this.pieces,
    this.isShowTextTest = false,
    this.speed = 250,
  }) : super(key: key);

  @override
  State<WheelSpin> createState() => _WheelSpinState(controller);
}

class _WheelSpinState extends State<WheelSpin> with TickerProviderStateMixin {
  _WheelSpinState(WheelSpinController _controller) {
    _controller.startWheel = startWheel;
    _controller.stopWheel = stopWheel;
  }

  late final AnimationController _controllerStart = AnimationController(
    duration: Duration(milliseconds: widget.speed * 2),
    vsync: this,
  );

  late final AnimationController _controllerFinish = AnimationController(
    duration: Duration(milliseconds: widget.speed * 5),
    vsync: this,
  );

  late final AnimationController _controllerMiddle = AnimationController(
    duration: Duration(milliseconds: widget.speed * 2),
    vsync: this,
  );

  int statusWheel = 0;
  bool isNhanKetQua = false;
  int indexResuft = 0;
  double angle = 0;
  int pieces = 0;
  List<String> items = [];
  bool isStart = false;

  Future<void> _loadLastResult() async {
    print("ssssssssssssssddff");
    setState(() {
      int lastResult = 20 - SharedPreferencesUtil.getLastResult() * 2;
      // If there's a last result, calculate the angle and set it
      if (lastResult > 0) {
        // angle= 22.15 - lastResult * 2;
        angle = (lastResult / widget.pieces) * 2 * pi;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pieces = widget.pieces;
    _loadLastResult();
    _controllerStart.addStatusListener((status) {
      if (!isStart) return;
      if (status == AnimationStatus.completed) {
        if (!isNhanKetQua) {
          _controllerStart.reset();
          _controllerStart.forward();
        } else {
          setState(() {
            statusWheel = 1;
            _controllerStart.stop();
            _controllerMiddle.forward();
          });
        }
      }
    });

    _controllerMiddle.addListener(() {
      if (!isStart) return;
      double radiaus = indexResuft / pieces + widget.offset;
      if (_controllerMiddle.value >= radiaus) {
        setState(() {
          statusWheel = 2;
          angle = radiaus * 2 * pi;
          _controllerMiddle.stop();
          _controllerFinish.forward();
        });
      }
    });
  }

  reset() {
    setState(() {});
    isStart = false;
    statusWheel = 0;
    angle = 0;
    _controllerMiddle.reset();
    _controllerFinish.reset();
    _controllerStart.reset();
    isNhanKetQua = false;
  }

  void nhanketqua(int index) {
    isNhanKetQua = true;
    indexResuft = index;
  }

  Animation<double> getAnimation() {
    if (statusWheel == 0) return _controllerStart.view;
    if (statusWheel == 1) return _controllerMiddle.view;
    return _controllerFinish.view;
  }

  @override
  void dispose() {
    _controllerStart.dispose();
    _controllerFinish.dispose();
    _controllerMiddle.dispose();
    super.dispose();
  }

  void startWheel() {
    reset();
    isStart = true;
    _controllerStart.forward();
  }

  void stopWheel(int index) {
    print("sssssss");
    nhanketqua(index);
    widget.controller.targetNumber = index;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: getAnimation(),
      child: Transform.rotate(
        angle: angle,
        child: Image.asset(
          widget.pathImage,
          width: widget.withWheel,
        ),
      ),
    );
  }
}
