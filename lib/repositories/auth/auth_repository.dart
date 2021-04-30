import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:yukti/models/app_user_model.dart';
import 'package:yukti/models/failure_model.dart';
import 'package:yukti/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //   @override
  // Stream<auth.User> get user => _firebaseAuth.userChanges();

  AppUser? _appUser(User? user) {
    if (user == null) {
      return null;
    }
    return AppUser(
      uid: user.uid,
      photoUrl: user.photoURL,
      name: user.displayName,
    );
  }

  @override
  Future<AppUser?> createUserWithEmailAndPassword(
      {String? email, String? password}) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!);
    return _appUser(userCredential.user);
  }

  @override
  Future<AppUser?> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _appUser(user);
  }

  @override
  Stream<AppUser?> get onAuthChanges =>
      _firebaseAuth.userChanges().map((user) => _appUser(user));

  @override
  Future<AppUser?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      return _appUser(userCredential.user);
    } on FirebaseAuthException catch (error) {
      throw Failure(message: error.message!, code: error.code);
    } on PlatformException catch (error) {
      throw Failure(message: error.message!, code: error.code);
    } catch (error) {
      throw Failure(message: error.toString());
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        print(userCredential.user?.photoURL);
        return _appUser(userCredential.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign In aborted',
      );
    }
  }

  @override
  Future<void> signOutUser() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void>? forgotPassword({String? email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email!);
    } catch (error) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'User not found',
      );
    }
  }
}
