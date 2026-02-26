import 'package:flutter/material.dart';

class ContainerInsideDismissable extends StatelessWidget {
  final Color color;
  final AlignmentGeometry? alignment;
  final double paddingLeft;
  final double paddingRight;
  final IconData icon;
  final Color iconColor;

  const ContainerInsideDismissable({
    super.key,
    required this.color,
    required this.alignment,
    required this.paddingLeft,
    required this.paddingRight,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: alignment,
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}
