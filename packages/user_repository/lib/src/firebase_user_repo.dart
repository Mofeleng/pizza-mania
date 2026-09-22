
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }): _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<AppUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield AppUser.empty;
      } else {
        yield await usersCollection
          .doc(firebaseUser.uid)
          .get()
          .then((val) =>
            AppUser.fromEntity(AppUserEntity.fromJSON(val.data()!))
          );
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  signUp(user, String password) async {
    try {
      UserCredential createdUser = await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: password);
      user.userId = createdUser.user!.uid;

      return user;

    } catch(e) {
      log(e.toString());
      rethrow;
    }
  }

   @override
  Future<void> setUserData(user) async {
    try {
      await usersCollection
        .doc(user.userId)
        .set(user.toEntity().toJSON());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  } 
}