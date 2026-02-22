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
  Future<User?> currentUser() async {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() async {
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }
}
