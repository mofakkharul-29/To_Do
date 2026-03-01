import 'package:flutter/material.dart';

class CustomLinearContainer extends StatelessWidget {
  final double progress;

  const CustomLinearContainer({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final double safeProgress = progress.clamp(0.0, 1.0);

    return Container(
        height: 12,
        decoration: BoxDecoration(
          color: const Color.fromARGB(137, 110, 109, 109),
          borderRadius: BorderRadius.circular(6),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.easeInOut,
                  width:
                      constraints.maxWidth * safeProgress,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            );
          },
        ),
      );
  }
}
