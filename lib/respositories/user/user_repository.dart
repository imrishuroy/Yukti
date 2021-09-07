import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yukti/config/paths.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/models/failure.dart';
import 'package:yukti/respositories/user/base_user_repo.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<AppUser?> getUserById({required String? userId}) async {
    try {
      final snap = await _firestore
          .collection(Paths.users)
          .doc(userId)
          .withConverter<AppUser>(
              fromFirestore: (snapshot, _) => AppUser.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .get();
      return snap.data();
    } catch (error) {
      print('Error getting current user');
      throw Failure(message: 'Error getting current user');
    }
  }

  Future<void> addUserProfile({required AppUser user}) async {
    try {
      await _firestore
          .collection(Paths.users)
          .doc(user.uid)
          .update(user.toMap());
    } catch (error) {
      print('Error adding user profile ${error.toString()}');
      throw error;
    }
  }
}
