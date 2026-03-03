import 'package:flutter/material.dart';

class CustomDevider extends StatelessWidget {
  final String text;
  const CustomDevider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: getDivider(10.5, 5.0)),
        Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
          ),
        Expanded(child: getDivider(5.0, 10.0)),
      ],
    );
  }

  Widget getDivider(double indent, double endIndent) {
    return Divider(
      color: Colors.black87,
      indent: indent,
      endIndent: endIndent,
      height: 1.2,
      thickness: 2.2,
    );
  }
}
