import 'package:yukti/models/models.dart';

abstract class BaseAuthRepository {
  Stream<AppUser?> get onAuthChanges;
  Future<AppUser?> currentUser();
  Future<AppUser?> createUserWithEmailAndPassword({
    String? email,
    String? password,
  });
  Future<AppUser?> signInWithEmailAndPassword({
    String? email,
    String? password,
  });
  Future<AppUser?> signInWithGoogle();
  Future<void> signOutUser();
  Future<void>? forgotPassword({String? email});
}
