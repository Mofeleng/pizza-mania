
import 'package:user_repository/src/entities/entities.dart';

class AppUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  AppUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart
  });

  static final empty = AppUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false
  );

  // Class -> Json map
  AppUserEntity toEntity() {
    return AppUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart
    );
  }

  // Json map -> class
  static AppUser fromEntity(AppUserEntity entity) {
    return AppUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $hasActiveCart';
  }
}
