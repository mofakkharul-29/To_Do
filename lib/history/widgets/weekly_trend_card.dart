import 'package:flutter/material.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/history/widgets/weekly_trend_helper.dart';

class WeeklyTrendCard extends StatelessWidget {
  final List<TaskModel> tasks;

  const WeeklyTrendCard({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final result = WeeklyTrendHelper.calculate(tasks);

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
            children: [
              const Text(
                "Rate Yourself Weekly",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                "${result.currentWeekCount} tasks completed this week",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              if (result.lastWeekCount > 0)
                Text(
                  result.difference >= 0
                      ? "+${result.difference} from last week"
                      : "${result.difference} from last week",
                  style: TextStyle(
                    fontSize: 15,
                    color: result.isImproved
                        ? const Color.fromARGB(255, 12, 20, 126)
                        : Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                const Text(
                  "No data from last week",
                  style: TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
