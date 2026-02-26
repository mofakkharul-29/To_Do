import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/tasks/domain/repository/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((
  ref,
) {
  return TaskRepository(FirebaseFirestore.instance);
});
