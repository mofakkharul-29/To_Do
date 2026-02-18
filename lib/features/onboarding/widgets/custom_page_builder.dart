import 'package:flutter/material.dart';

class CustomPageBuilder extends StatelessWidget {
  final String image;
  const CustomPageBuilder({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        color: const Color.fromARGB(255, 209, 160, 156),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.asset(image),
          ),
          // Image.asset(image),
        ],
      ),
    );
  }
}
