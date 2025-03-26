import 'dart:math';

import 'package:flutter/material.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/view_model/spin_result_view_model.dart';
import 'package:provider/provider.dart';

import '../controller/spin_controller.dart';

class SpinWheel extends StatefulWidget {
  final SpinController controller;
  final String pathImage;
  final double withWheel;
  final int pieces;
  final double offset;
  final int speed;
   const SpinWheel(
      {super.key,
      required this.controller,
      required this.pathImage,
      required this.withWheel,
      this.offset = 0,
      required this.pieces,
      this.speed = 1100});

  @override
  State<SpinWheel> createState() => _BlueWheelSpinState(controller);
}

class _BlueWheelSpinState extends State<SpinWheel>
    with TickerProviderStateMixin {
  _BlueWheelSpinState(SpinController controller) {
    controller.spinStartWheel = startWheel;
    controller.spinStopWheel = stopWheel;
  }
  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 0,
  );
  late final AnimationController _controllerStart = AnimationController(
    duration: Duration(milliseconds: widget.speed),
    vsync: this,
  );
  late final AnimationController _controllerFinish = AnimationController(
    duration: Duration(milliseconds: widget.speed * 2),
    vsync: this,
  );

  late final AnimationController _controllerMiddle = AnimationController(
    duration: Duration(milliseconds: widget.speed),
    vsync: this,
  );

  late final Animation<double> _animationFinish = CurvedAnimation(
    parent: _controllerFinish,
    curve: Curves.linear,
  );
  late final Animation<double> _animationStart = CurvedAnimation(
    parent: _controllerStart,
    curve: Curves.linear,
  );

  late final Animation<double> _animationMiddle = CurvedAnimation(
    parent: _controllerMiddle,
    curve: Curves.linear,
  );

  int statusWheel = 0;

  bool isNhanKetQua = false;
  int indexResult = 0;
  double angle = 0;
  int pieces = 0;

  void _loadLastResult(int resultData)  {
    double radius = resultData / 10 + widget.offset;
    setState(() {
      double lastResult = radius * 2 * pi;
        angle = lastResult;
    });
  }


  List<String> items = [];
  bool isStart = false;
  @override
  void initState() {
    super.initState();
    pieces = widget.pieces;

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
      double radius = indexResult / pieces + widget.offset;
      if (_controllerMiddle.value >= radius) {
        setState(() {
          statusWheel = 2;
          angle = radius * 2 * pi;
          _controllerMiddle.stop();
          _controllerFinish.forward();
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 500),(){
      final lastIndex =  Provider.of<SpinResultViewModel>(context,listen: false).spinResultList.first.winIndex;
      _loadLastResult(lastIndex!);
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

  void nhanKetQua(int index) {
    isNhanKetQua = true;
    indexResult = index;
  }

  Animation<double> getAnimation() {
    if (statusWheel == 0) return _animationStart;
    if (statusWheel == 1) return _animationMiddle;
    return _animationFinish;
  }

  @override
  void dispose() {
    if (_controllerStart.isAnimating) _controllerStart.dispose();
    if (_controllerFinish.isAnimating) _controllerFinish.dispose();
    if (_controllerMiddle.isAnimating) _controllerMiddle.dispose();
    super.dispose();
  }

  void startWheel() {
    reset();
    isStart = true;
    _controllerStart.forward();
  }

  void stopWheel(int index) {
    nhanKetQua(index);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: getAnimation(),
        child: Transform.rotate(
          angle: angle,
          child: Container(
            width: widget.withWheel,
            height: widget.withWheel,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(widget.pathImage),
              fit: BoxFit.cover,
            )),
          ),
        ));
  }
}
