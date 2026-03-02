import 'package:flutter/material.dart';

class GetButtonWithText extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const GetButtonWithText({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: Colors.black87,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              fontWeight: FontWeight.w500,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
