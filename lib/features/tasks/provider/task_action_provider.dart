import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/tasks/data/task_action_notifier.dart';

final taskActionProvider =
    AsyncNotifierProvider<TaskActionNotifier, void>(
      TaskActionNotifier.new,
    );
