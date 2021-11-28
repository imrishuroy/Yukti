import '/models/app_user.dart';

abstract class BaseUserRepository {
  Future<AppUser?> getUserById({required String? userId});
  Stream<AppUser?> streamUserById({required String? userId});
  Future<void> addUserProfile({required AppUser user});
}
