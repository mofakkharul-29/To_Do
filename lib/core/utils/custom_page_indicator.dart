import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const CustomPageIndicator({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.grey,
      ),
    );
  }
}
