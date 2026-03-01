import 'package:to_do/features/tasks/domain/task_model.dart';

class RecentCompleteHelper {
  static List<TaskModel> getRecent(
    List<TaskModel> tasks, {
    limit = 5,
  }) {
    final completedTasks = tasks
        .where((task) => task.isComplete)
        .toList();

    completedTasks.sort(
      (a, b) => b.completedAt!.compareTo(a.completedAt!),
    );

    return completedTasks.take(limit).toList();
  }
}
