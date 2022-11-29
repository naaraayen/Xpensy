import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxShape shape;
  final Widget? child;
  const NeumorphicContainer({
    super.key,
    this.child,
    this.borderRadius = 15,
    this.padding ,
    this.color,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          shape: shape,
          color: color,
          borderRadius: shape == BoxShape.rectangle? BorderRadius.circular(borderRadius) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(12, 12),
              blurRadius: 18,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-12, -12),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ]),
      child: child,
    );
  }
}
