// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_final_fields, unused_local_variable, unused_element, avoid_print, prefer_typing_uninitialized_variables, unused_field, unused_import

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<dynamic> signIn({String? email, String? password});
  Future<void> signOut();
}

class FirebaseAuthService extends AuthService {
  // Get current user:
  User? get currentUser => FirebaseAuth.instance.currentUser;

  // Create a user account:
  Future<dynamic> createUserAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User account created successfully: ${userCredential.user!.email}');
      return userCredential;
    } catch (e) {
      log('Failed to create user account: $e');
      return null;
    }
  }

  // Log in user:
  @override
  Future<void> signIn({String? email, String? password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    log('User logged in successfully: ${userCredential.user!.email}');
  }

  //Sign out user:
  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Reset user's password:
  Future<void> resetUserPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
