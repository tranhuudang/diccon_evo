import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  late final GoogleSignInAccount? gUser;
  late final GoogleSignInAuthentication gAuth;

  Future<User?> signUpWithEmailPassword(
  //{
    // required String email,
    // required String password,
  //}
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'myworld.ilovehd@gmail.com',
        password: 'huudang;;y97',
      );

      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        if (kDebugMode) {
          print('Verification email is sent');
        }
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Error during sign up: ${e.message}');
      }
      return null;
    }
  }

  Future<User?> signInWithEmailPassword(
  //     {
  //   required String email,
  //   required String password,
  // }
  ) async {
    final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'myworld.ilovehd@gmail.com',
      password: 'huudang;;y97',
    );
    return response.user;
  }

  void deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.delete();
        if (kDebugMode) {
          print('User account deleted successfully.');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to delete user account: $e');
        }
        // Handle error: display a message to the user or perform additional actions
      }
    } else {
      if (kDebugMode) {
        print('No user signed in.');
      }
      // Handle case where no user is currently signed in
    }
  }

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
        print("[Google Sign In Service Error] : $e");
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
