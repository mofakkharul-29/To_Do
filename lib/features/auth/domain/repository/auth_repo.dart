import 'package:to_do/features/auth/domain/app_user.dart';

abstract class AuthModel {
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String name,
    String password,
  );

  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> logOut();
  Future<String> sendPasswordResetEmail(String email);
  Future<AppUser?> logInWithGoogle();
  Future<void> deleteAccount();
  Future<AppUser?> getCurrentUser();
}
