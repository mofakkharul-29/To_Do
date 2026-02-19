import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
