import 'package:flutter/material.dart';
import 'package:to_do/core/utils/custom_text.dart';
import 'package:to_do/features/profile/widgets/custom_linear_container.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';

class Activities extends StatelessWidget {
  final List<TaskModel> tasks;
  const Activities({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final int total = tasks.length;
    final int completed = tasks
        .where((task) => task.isComplete)
        .length;
    final int pending = total - completed;

    final double completedProgress = total == 0
        ? 0.0
        : completed / total;
    final double pendingProgress = total == 0
        ? 0.0
        : pending / total;
    final double rateProgress = completedProgress;

    return Card(
      color: Colors.transparent,
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(110),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 90, 89, 89),
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(2.5, 0.0),
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 90, 89, 89),
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(-2.5, 2.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRow(
                label: 'Total : ',
                progress: total == 0 ? 0.0 : 1.0,
                last: ' $total',
              ),
              const SizedBox(height: 5),
              buildRow(
                label: 'Completed : ',
                progress: completedProgress,
                last: ' $completed',
              ),
              const SizedBox(height: 5),
              buildRow(
                label: 'Pending : ',
                progress: pendingProgress,
                last: ' $pending',
              ),
              const SizedBox(height: 5),
              buildRow(
                label: 'Rate : ',
                progress: rateProgress,
                last:
                    ' ${(completedProgress * 100).toStringAsFixed(1)}%',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow({
    required String label,
    required double progress,
    required String last,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 90,
          child: CustomText(
            text: label,
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
        Expanded(
          child: CustomLinearContainer(progress: progress),
        ),
        const SizedBox(width: 8),
        CustomText(
          text: last,
          color: Colors.black87,
          fontSize: 15,
        ),
      ],
    );
  }
}
