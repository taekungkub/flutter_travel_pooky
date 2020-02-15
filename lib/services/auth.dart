import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final userRef = FirebaseDatabase.instance.reference().child('users');

  static final _auth = FirebaseAuth.instance;

  static void signUpUser(
    BuildContext context,
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      signedInUser.updateProfile(userUpdateInfo);
      final userRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(signedInUser.uid)
          .set({
        "email": signedInUser.email,
        "name": name,
        "role": role,
        "photoUrl": signedInUser.photoUrl,
      });
    } catch (e) {}
  }
}
