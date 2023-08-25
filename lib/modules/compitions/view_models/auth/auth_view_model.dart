// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';

import '../../firebase_auth/firebase_auth_service.dart';
import '../../firebase_auth/google_auth_service.dart';


  //final AuthService _facebookAuth = FacebookAuthService();
  final AuthService _googleAuth = GoogleAuthService();
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();

  Future<User?> signInWithFacebook() async {
    return null;
  }

  Future signInWithGoogle() async {
    await _googleAuth.signIn();
    return _firebaseAuth.currentUser;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signIn(email: email, password: password);
  }

  Future<void> creatNewAccount(String email, String password) async {
    await _firebaseAuth.createUserAccount(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

