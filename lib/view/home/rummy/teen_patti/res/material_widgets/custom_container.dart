import 'package:game_on/material_imports.dart';

class ContBox extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final DecorationImage? image;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final void Function()? onTap;
  final BoxBorder? border;
  final AlignmentGeometry? alignment;
  final BoxShape? shape;
  final Clip clipBehavior;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  const ContBox(
      {super.key,
      this.height,
      this.width,
      this.child,
      this.image,
      this.borderRadius,
      this.padding,
      this.margin,
      this.radius = 2,
      this.color,
      this.onTap,
      this.border,
      this.alignment,
      this.shape = BoxShape.rectangle,
      this.clipBehavior = Clip.hardEdge, this.boxShadow, this.gradient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: clipBehavior,
        alignment: alignment ?? Alignment.center,
        padding:
            padding,
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          shape: shape ?? BoxShape.rectangle,
          border: border,
          color: color,
          image: image,
          borderRadius: shape != BoxShape.circle
              ? borderRadius ?? BorderRadius.circular(radius)
              : null,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
