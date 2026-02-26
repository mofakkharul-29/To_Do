import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;

  TaskRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _taskRef(
    String userid,
  ) {
    return _firestore
        .collection('users')
        .doc(userid)
        .collection('tasks');
  }

  Stream<List<TaskModel>> getTasks(String userId) {
    return _taskRef(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    TaskModel.fromMap(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  Future<void> addTask(
    String userId,
    TaskModel task,
  ) async {
    await _taskRef(userId).add(task.toMap());
  }

  Future<void> updateTask({
    required String userId,
    required String taskId,
    String? title,
    String? description,
  }) async {
    await _taskRef(userId).doc(taskId).update({
      // ignore: use_null_aware_elements
      if (title != null) 'title': title,
      // ignore: use_null_aware_elements
      if (description != null) 'description': description,
    });
  }

  Future<void> toggleComplete({
    required String userId,
    required String taskId,
    required bool isCompleted,
  }) async {
    await _taskRef(userId).doc(taskId).update({
      'completedAt': isCompleted
          ? Timestamp.fromDate(DateTime.now())
          : null,
    });
  }

  Future<void> deleteTask({
    required String userId,
    required String taskId,
  }) async {
    await _taskRef(userId).doc(taskId).delete();
  }
}
