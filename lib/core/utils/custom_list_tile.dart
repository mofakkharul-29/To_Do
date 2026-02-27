import 'package:flutter/material.dart';
import 'package:to_do/features/tasks/data/task_action_notifier.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';

class CustomListTile extends StatelessWidget {
  final TaskModel task;
  final TaskActionNotifier notifier;
  const CustomListTile({
    super.key,
    required this.task,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black87, width: 2.5),
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isComplete
              ? TextDecoration.lineThrough
              : null,
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
      subtitle: task.descriptions != null
          ? Text(task.descriptions!)
          : null,
      trailing: Checkbox(
        value: task.isComplete,
        onChanged: (_) {
          notifier.toggleTask(task);
        },
      ),
    );
  }
}
