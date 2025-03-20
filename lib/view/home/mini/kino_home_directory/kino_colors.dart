
import 'package:flutter/material.dart';

class KiNoColors{
  static  LinearGradient kiNoBg =
  const LinearGradient(
    colors: [
      Color(0xff005500),
      Color(0xff2b7009),
      Color(0xff569123 ),
      Color(0xff569123 ),
      Color(0xff569123 ),
      Color(0xff2b7009),
      Color(0xff2b7009),

    ],
    stops: [0.0, 0.1,0.4, 0.5,0.6, 0.9, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static  LinearGradient kiNoBtn =
  const LinearGradient(
    colors: [
      Color(0xff005500),
      Color(0xff2b7009),
      Color(0xff2b7009 ),
      Color(0xff2b7009 ),
      Color(0xff2b7009 ),
      Color(0xff2b7009),
      Color(0xff2b7009),

    ],
    stops: [0.0, 0.1,0.4, 0.5,0.6, 0.9, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );


  static const LinearGradient greenButton =
  LinearGradient(
    colors: [
      Color(0xff2b7009),
      Color(0xff569123),
      Color(0xff569123),
      Color(0xff2b7009 ),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient kiNoYellowBtn =
  LinearGradient(
    colors: [
      Colors.orange,
      Colors.amber,
      Colors.amber,
      Colors.orange,
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
      static const LinearGradient kiNoBlackBtn = LinearGradient(
    colors: [
      Color(0xff032506), // Dark green
      Color(0xff052C05), // Slightly lighter green
      Color(0xff052C05), // Slightly lighter green
      Color(0xff032506), // Dark green
    ],
    stops: [0.0, 0.3, 0.7, 1.0], // Color stops for smooth transitions
    begin: Alignment.centerLeft, // Start point of the gradient
    end: Alignment.centerRight, // End point of the gradient
  );
  static  const greenGradient= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff003b09), Color(0xff062b12), Color(0xff010905)],
  );
  static  const orangeGradient= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [ Color(0xfff8bc00), Color(0xffff9d07)],
  );

  static const LinearGradient whiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF), // Pure white
      Color(0xFFEEEEEE), // Light grey
    ],
  );


  static  LinearGradient redBtn =
  LinearGradient(
    colors: [
      Colors.red.shade800,
      Colors.red.shade700,
      Colors.red.shade600,
      Colors.red.shade700,
      Colors.red.shade800,
    ],
    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}