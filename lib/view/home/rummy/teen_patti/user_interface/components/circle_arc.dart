import '../../../../../../material_imports.dart';

class HalfCircleArc extends StatelessWidget {
  const HalfCircleArc({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
          Sizes.screenWidth / 4,
          Sizes.screenWidth < 700 || Sizes.screenWidth > 1000
              ? Sizes.screenWidth / 9
              : Sizes.screenHeight / 5),
      painter: HalfCirclePainter(),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height * 2);

    const Gradient gradient = LinearGradient(
      colors: [
        Color(0xffD4145A),
        Color(0xffFBB03B),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..arcTo(rect, 0, 3.14, false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
