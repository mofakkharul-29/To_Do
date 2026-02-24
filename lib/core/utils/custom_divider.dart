import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double indent;
  final double endIndent;
  final Color color;
  const CustomDivider({
    super.key,
    required this.indent,
    required this.endIndent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2.5,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }
}
