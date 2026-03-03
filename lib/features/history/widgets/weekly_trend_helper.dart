import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/features/history/widgets/weekly_trend_result.dart';

class WeeklyTrendHelper {
  static WeeklyTrendResult calculate(
    List<TaskModel> tasks,
  ) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final startOfCurrentWeek = today.subtract(
      Duration(days: today.weekday - 1),
    );

    final endOfCurrentWeek = startOfCurrentWeek.add(
      const Duration(days: 6),
    );

    final startOfLastWeek = startOfCurrentWeek.subtract(
      const Duration(days: 7),
    );

    final endOfLastWeek = startOfCurrentWeek.subtract(
      const Duration(days: 1),
    );

    int currentWeekCount = 0;
    int lastWeekCount = 0;

    for (final task in tasks) {
      if (!task.isComplete) continue;

      final completed = task.completedAt!;

      final completedDate = DateTime(
        completed.year,
        completed.month,
        completed.day,
      );

      if (!completedDate.isBefore(startOfCurrentWeek) &&
          !completedDate.isAfter(endOfCurrentWeek)) {
        currentWeekCount++;
      }

      if (!completedDate.isBefore(startOfLastWeek) &&
          !completedDate.isAfter(endOfLastWeek)) {
        lastWeekCount++;
      }
    }

    return WeeklyTrendResult(
      currentWeekCount: currentWeekCount,
      lastWeekCount: lastWeekCount,
    );
  }
}
