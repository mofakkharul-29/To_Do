import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.push('/tasks/add');
      },
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
