import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/domain/app_user.dart';

final appUserProvider = StreamProvider<AppUser?>((ref) {
  return FirebaseAuth.instance.authStateChanges().asyncMap((
    User? firebaseUser,
  ) async {
    if (firebaseUser == null) {
      return null;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (doc.exists) {
      return AppUser.fromMap(doc.data()!);
    } else {
      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? 'Unknown',
        photoUrl: firebaseUser.photoURL,
        createdAt: DateTime.now(),
      );
    }
  });
});
