import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String? descriptions;
  final DateTime createdAt;
  final DateTime? completedAt;

  TaskModel({
    required this.id,
    required this.title,
    this.descriptions,
    required this.createdAt,
    this.completedAt,
  });

  bool get isComplete => completedAt != null;

  TaskModel copyWith(
    String? id,
    String? title,
    String? descriptions,
    DateTime? createdAt,
    DateTime? completedAt,
  ) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      descriptions: descriptions ?? this.descriptions,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory TaskModel.fromMap(
    Map<String, dynamic> task,
    String documentId,
  ) {
    return TaskModel(
      // id: task['id'] as String,
      id: documentId,
      title: task['title'] as String,
      descriptions: task['descriptions'] as String?,
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
      'descriptions': descriptions,
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
    };
  }
}
