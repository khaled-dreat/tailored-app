// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_auth_service.dart';

class GoogleAuthService extends AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<UserCredential> signIn({String? email, String? password}) async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final userCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(userCredential);
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}
