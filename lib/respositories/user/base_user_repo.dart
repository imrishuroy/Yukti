import '/models/app_user.dart';

abstract class BaseUserRepository {
  Future<AppUser?> getUserById({required String? userId});
}
