import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/features/history/widgets/recent_complete_helper.dart';

class RecentCompletedCard extends StatelessWidget {
  final List<TaskModel> tasks;
  const RecentCompletedCard({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final recentTasks = RecentCompleteHelper.getRecent(
      tasks,
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What You’ve Accomplished",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              if (recentTasks.isEmpty)
                const Text("No completed tasks yet.")
              else
                ...List.generate(recentTasks.length, (
                  index,
                ) {
                  final task = recentTasks[index];
                  return Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(
                              255,
                              21,
                              73,
                              23,
                            ),
                            size: 18,
                          ),
                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(
                              task.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              overflow:
                                  TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            DateFormat(
                              'MMM d',
                            ).format(task.completedAt!),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          if (index !=
                              recentTasks.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Divider(height: 1),
                            ),
                        ],
                      ),
                    ],
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
