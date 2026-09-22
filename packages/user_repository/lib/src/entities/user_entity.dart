class AppUserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  AppUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart
  });

  Map<String, Object?> toJSON() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart
    };
  }
  
  static AppUserEntity fromJSON(Map<String, dynamic> doc) {
    return AppUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      hasActiveCart: doc['hasActiveCart']
    );
  }
}