import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color color;
  const CustomPageIndicator({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );
  }
}
