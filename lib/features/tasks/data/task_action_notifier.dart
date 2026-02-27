import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/features/tasks/provider/task_repository_provider.dart';

class TaskActionNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addTask(
    String title,
    String? description,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(taskRepositoryProvider);
      final userId = ref
          .read(asyncAuthNotifierProvider)
          .value!
          .uid;

      final task = TaskModel(
        id: '',
        title: title,
        descriptions: description,
        createdAt: DateTime.now(),
        completedAt: null,
      );
      await taskRepo.addTask(userId, task);
    });
  }

  Future<void> toggleTask(TaskModel task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(taskRepositoryProvider);
      final userId = ref
          .read(asyncAuthNotifierProvider)
          .value!
          .uid;

      await taskRepo.toggleComplete(
        userId: userId,
        taskId: task.id,
        isCompleted: !task.isComplete,
      );
    });
  }

  Future<void> deleteTask(TaskModel task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(taskRepositoryProvider);
      final userId = ref
          .read(asyncAuthNotifierProvider)
          .value!
          .uid;
      await taskRepo.deleteTask(
        userId: userId,
        taskId: task.id,
      );
    });
  }

  Future<void> updateTask(
    TaskModel task,
    String title,
    String? description,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(taskRepositoryProvider);
      final userId = ref
          .read(asyncAuthNotifierProvider)
          .value!
          .uid;
      await taskRepo.updateTask(
        userId: userId,
        taskId: task.id,
        title: title,
        description: description,
      );
    });
  }
}
