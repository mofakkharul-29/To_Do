import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;
  const ErrorPage({
    super.key,
    required this.error,
    required this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.toString()),
          const SizedBox(height: 20),
          Text('stackTrace: ${stackTrace.toString()}'),
        ],
      ),
    );
  }
}
