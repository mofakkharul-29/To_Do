import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do/features/auth/domain/app_user.dart';
import 'package:to_do/features/auth/domain/repository/auth_repo.dart';

class FirebaseAuthRepo implements AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String name,
    String password,
  ) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      final User? firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      await firebaseUser.updateDisplayName(name);

      final AppUser user = AppUser(
        uid: firebaseUser.uid,
        email: email,
        name: name,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      return user;
    } catch (e) {
      throw Exception('SignUp failed: $e');
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential credential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      final User? firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      final AppUser user = AppUser(
        uid: firebaseUser.uid,
        email: email,
        name: firebaseUser.displayName,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      return user;
    } catch (e) {
      throw Exception('Login failed $e');
    }
  }

  @override
  Future<AppUser?> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount =
          await _googleSignIn.signIn();
      if (googleAccount == null) return null;

      final GoogleSignInAuthentication authentication =
          await googleAccount.authentication;

      final OAuthCredential credential =
          GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken,
          );

      final UserCredential userCredential = await _auth
          .signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) return null;
      AppUser user = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code ==
          'account-exists-with-different-credential') {
        throw Exception(
          'Account exists with different sign-in method',
        );
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid credentials');
      } else if (e.code == 'operation-not-allowed') {
        throw Exception('Google sign-in not enabled');
      }
      throw Exception(
        'Google sign-in failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Login in failed: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final User? firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        return null;
      }

      AppUser user = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      return user;
    } catch (e) {
      throw Exception('problem getting user: $e');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _auth.signOut(),
      ]);
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No such a user logged in');
      }
      await _googleSignIn.signOut();
      await currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'Please log in again before deleting your account',
        );
      }
      throw Exception(
        'Failed to delete account: ${e.message}',
      );
    } catch (e) {
      throw Exception('Problem deleting account: $e');
    }
  }

  @override
  Future<String> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Password reset email! Check your inbox';
    } catch (e) {
      throw Exception('Problem sending email: $e');
    }
  }
}
