import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  Stream<AppUser?> get user;
  Future<AppUser> signUp(AppUser user, String password);
  Future<void> setUserData(AppUser user);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
}