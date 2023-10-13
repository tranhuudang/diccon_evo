import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  late final GoogleSignInAccount? gUser;
  late final GoogleSignInAuthentication gAuth;
  // Google sign in
  Future<User?> googleSignIn() async {
    try {
      // begin interactive sign in process
      gUser = await GoogleSignIn().signIn();

      //obtain auth details from request
      gAuth = await gUser!.authentication;

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      // finally lets sign in
      await FirebaseAuth.instance.signInWithCredential(credential);
      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      if (kDebugMode) {
        print("[Google Sign In Service] : $e");
      }
      return null;
    }
  }

// Google sign out
  Future<void> googleSignOut() async {
    try {
      // Sign out from Firebase Auth
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (error) {
      if (kDebugMode) {
        print("[Google Sign In Service] : Error during sign out: $error");
      }
    }
  }
}
