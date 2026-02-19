import 'package:flutter/material.dart';

class CustomPageBuilder extends StatelessWidget {
  final String image;
  final String title;
  const CustomPageBuilder({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
        color: const Color.fromARGB(255, 201, 201, 202),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 530,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                // bottomLeft: Radius.circular(5.0),
                // bottomRight: Radius.circular(5.0),
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
          // Image.asset(image),
        ],
      ),
    );
  }
}
