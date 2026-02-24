import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/data/firebase_auth_repo.dart';
import 'package:to_do/features/auth/domain/app_user.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  late final FirebaseAuthRepo _authRepo;
  late final FirebaseFirestore _firestore;

  @override
  Future<AppUser?> build() async {
    _authRepo = FirebaseAuthRepo();
    _firestore = FirebaseFirestore.instance;

    final AppUser? user = await _authRepo.getCurrentUser();
    return user;
  }

  Future<void> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _authRepo
          .loginWithEmailAndPassword(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _authRepo
          .logInWithGoogle();
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set({
              ...user.toMap(),
            }, SetOptions(merge: true));
      }
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> registerWithEmailPassword(
    String email,
    String name,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _authRepo
          .registerWithEmailPassword(email, name, password);
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set({
              ...user.toMap(),
            }, SetOptions(merge: true));
      }
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logOut() async {
    state = AsyncValue.loading();
    try {
      await _authRepo.logOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAccount() async {
    state = AsyncValue.loading();
    try {
      final AppUser? currentUser = state.value;
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .delete();
        await _authRepo.deleteAccount();
        state = const AsyncValue.data(null);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      return await _authRepo.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}

final asyncAuthNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AppUser?>(
      () => AuthNotifier(),
    );
