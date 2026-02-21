import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final void Function()? onPressed;
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(
          MediaQuery.of(context).size.width - 45,
          50,
        ),
        foregroundColor: Colors.white,
        elevation: 6,
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 13,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
