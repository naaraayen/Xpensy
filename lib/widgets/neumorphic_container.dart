import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxShape shape;
  final double offset;
  final double blurRadius;
  final Widget? child;
  const NeumorphicContainer({
    super.key,
    this.child,
    this.borderRadius = 15,
    this.padding,
    this.color,
    this.offset = 12,
    this.blurRadius = 18,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          shape: shape,
          color: color,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(offset, offset),
              blurRadius: blurRadius,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-offset, -offset),
              blurRadius: blurRadius,
              spreadRadius: 1,
            ),
          ]),
      child: child,
    );
  }
}
