import 'package:flutter/material.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/history/widgets/custom_pie_chart.dart';

class CustomCard extends StatelessWidget {
  final List<TaskModel> tasks;
  const CustomCard({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks
        .where((task) => task.completedAt != null)
        .toList();
    final pendingTasks = tasks
        .where((task) => task.completedAt == null)
        .toList();
    double percentage = (tasks.isEmpty)
        ? 0.0
        : (completedTasks.length / tasks.length) * 100;
    String formattedPercentage = percentage.toStringAsFixed(
      2,
    );

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
            const BoxShadow(
              color: Color.fromARGB(255, 90, 89, 89),
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(2.5, 0.0),
            ),
            const BoxShadow(
              color: Color.fromARGB(255, 90, 89, 89),
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(-2.5, 2.5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getTaskText(
                    'Total Tasks',
                    ' : ${tasks.length}',
                    48,
                    Colors.black87,
                  ),
                  getTaskText(
                    'Completed Tasks',
                    ' : ${completedTasks.length}',
                    1.5,
                    Colors.green,
                  ),
                  getTaskText(
                    'Pending Tasks',
                    ' : ${pendingTasks.length}',
                    22.5,
                    Colors.amber,
                  ),
                  getTaskText(
                    'Completion',
                    ' : $formattedPercentage %',
                    7,
                    Color.fromARGB(255, 97, 20, 231),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 130,
              height: 130,
              child: CustomPieChart(
                totalTasks: tasks.length,
                completedTasks: completedTasks.length,
                size: 130,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget getTaskText(
    String firstText,
    String lastText,
    double width,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 6.0,
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 5.5, backgroundColor: color),
          const SizedBox(width: 5),
          Text(
            firstText,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              lastText,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
