import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(
          158,
          117,
          116,
          116,
        ),
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
