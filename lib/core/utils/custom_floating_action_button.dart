import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      foregroundColor: Colors.black87,
      backgroundColor: Colors.green,
      shape: CircleBorder(),
      child: Icon(
        Icons.add,
        fontWeight: FontWeight.w800,
        size: 25,
      ),
    );
  }
}
