import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/utils/container_inside_dismissable.dart';
import 'package:to_do/core/utils/custom_list_tile.dart';
import 'package:to_do/features/tasks/provider/task_action_provider.dart';
import 'package:to_do/features/tasks/provider/task_stream_provider.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(
      taskStreamNotifierProvider,
    );

    final taskActionProviderNotifier = ref.read(
      taskActionProvider.notifier,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        175,
        173,
        173,
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.task_alt,
                    size: 50,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No tasks added yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap + to create your first task',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: ValueKey(task.id),
                background: ContainerInsideDismissable(
                  color: Colors.green,
                  alignment: Alignment.centerLeft,
                  paddingLeft: 20.0,
                  paddingRight: 0.0,
                  icon: Icons.check,
                  iconColor: Colors.white,
                ),
                secondaryBackground:
                    ContainerInsideDismissable(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      paddingLeft: 0.0,
                      paddingRight: 20.0,
                      icon: Icons.delete,
                      iconColor: Colors.white,
                    ),
                confirmDismiss: (direction) async {
                  final actionNotifier = ref.read(
                    taskActionProvider.notifier,
                  );
                  if (direction ==
                      DismissDirection.startToEnd) {
                    await actionNotifier.toggleTask(task);
                    return false;
                  } else {
                    await actionNotifier.deleteTask(task);
                    return true;
                  }
                },
                child: CustomListTile(
                  task: task,
                  notifier: taskActionProviderNotifier,
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
