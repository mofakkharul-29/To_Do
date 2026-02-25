import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String uid;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? completedAt;

  TaskModel({
    required this.uid,
    required this.title,
    this.description,
    required this.createdAt,
    this.completedAt,
  });

  TaskModel copyWith(
    String? uid,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
  ) {
    return TaskModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> task) {
    return TaskModel(
      uid: task['uid'] as String,
      title: task['title'] as String,
      description: task['description'] as String?,
      createdAt: (task['createdAt'] as Timestamp).toDate(),
      completedAt: task['completedAt'] != null
          ? (task['completedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'descriptions': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
    };
  }

  bool get isComplete => completedAt != null;
}
