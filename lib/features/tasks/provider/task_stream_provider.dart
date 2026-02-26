import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/features/tasks/provider/task_repository_provider.dart';

class TaskStreamNotifier
    extends StreamNotifier<List<TaskModel>> {
  @override
  Stream<List<TaskModel>> build() {
    final userId = ref
        .watch(asyncAuthNotifierProvider)
        .value
        ?.uid;
    final taskRepo = ref.watch(taskRepositoryProvider);

    if (userId == null) {
      return const Stream.empty();
    }

    return taskRepo.getTasks(userId);
  }
}

final taskStreamNotifierProvider =
    StreamNotifierProvider<
      TaskStreamNotifier,
      List<TaskModel>
    >(TaskStreamNotifier.new);
