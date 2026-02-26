import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? completedAt;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.completedAt,
  });

  bool get isComplete => completedAt != null;

  TaskModel copyWith(
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
  ) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> task, String documentId) {
    return TaskModel(
      // id: task['id'] as String,
      id: documentId,
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
      // 'id': id,
      'title': title,
      'descriptions': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
    };
  }
}
