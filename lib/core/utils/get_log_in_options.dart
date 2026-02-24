import 'package:flutter/material.dart';

class GetLogInOptions extends StatelessWidget {
  const GetLogInOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getOptions('assets/images/google.png', () {}),
        getOptions('assets/images/facebook.png', () {}),
        getOptions('assets/images/phone.png', () {}),
      ],
    );
  }

  Widget getOptions(
    String image,
    void Function()? onPressed,
  ) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent,
        elevation: 0.0,
        shape: CircleBorder(side: BorderSide.none),
        fixedSize: Size(100, 100),
      ),
      child: Image.asset(image),
    );
  }
}
