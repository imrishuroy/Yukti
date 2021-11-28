import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/app_user.dart';
import '/models/failure.dart';
import '/respositories/user/base_user_repo.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
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
      throw const Failure(message: 'Error getting current user');
    }
  }

  @override
  Stream<AppUser?> streamUserById({required String? userId}) {
    try {
      return _firestore
          .collection(Paths.users)
          .doc(userId)
          .withConverter<AppUser>(
              fromFirestore: (snapshot, _) => AppUser.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots()
          .map((snap) => snap.data());
    } catch (error) {
      print('Error getting user profile ${error.toString()}');
      throw const Failure(message: 'Error getting current user');
    }
  }

  @override
  Future<void> addUserProfile({required AppUser user}) async {
    try {
      await _firestore
          .collection(Paths.users)
          .doc(user.uid)
          .update(user.toMap());
    } catch (error) {
      print('Error adding user profile ${error.toString()}');
      rethrow;
    }
  }
}
