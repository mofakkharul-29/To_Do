import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.createdAt,
  });

  AppUser copyWith(
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
  ) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> user) {
    return AppUser(
      uid: user['uid'] as String,
      email: user['email'] as String,
      name: user['name'] as String,
      photoUrl: user['photoUrl'] as String?,
      createdAt: user['createdAt'] is Timestamp
          ? (user['createdAt'] as Timestamp).toDate()
          : DateTime.parse(user['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
