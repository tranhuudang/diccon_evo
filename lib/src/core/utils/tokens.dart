import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core.dart';

class Tokens {
  Tokens._();
  static final Tokens _instance = Tokens._();

  int _tokens = 0;

  static Future<int> get token async {
    _instance._tokens = await _instance._getToken();
    return _instance._tokens;
  }

  static setToken({required int toValue}) async {
    _instance._tokens = toValue;
    await _instance._setToken(toValue);
  }

  static addToken({required int withAdditionalValueOf}) async {
    await _instance._addToken(withAdditionalValueOf);
    _instance._tokens = await _instance._getToken();
  }

  static reduceToken({required int byValueOf}) async {
    await _instance._reduceToken(byValueOf);
    _instance._tokens = await _instance._getToken();
  }

  Future<String> getEmailFromConnectedDevice() async {
    final code = await Md5Generator.composeMD5IdForFirebaseDbDesktopLogin();
    final dataTrack = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.login)
        .doc(code);
    final documentSnapshot = await dataTrack.get();

    if (documentSnapshot.exists) {
      var userId = documentSnapshot.data()?["userEmail"];
      return userId;
    } else {
      return '';
    }
  }

  Future<int> _getToken() async {
    String? email = await getUserEmail();
    if (email.isNotEmpty) {
      String premiumUserMD5 =
          Md5Generator.composeMd5IdForFirebaseDbPremium(userEmail: email);
      final dataTrack = FirebaseFirestore.instance
          .collection(FirebaseConstant.firestore.premium)
          .doc(premiumUserMD5);
      final documentSnapshot = await dataTrack.get();

      if (documentSnapshot.exists) {
        var resultTokens = documentSnapshot.data()?["token"];
        final result = int.parse(resultTokens);
        return result;
      } else {
        return 0;
      }
    }
    return 0;
  }

  Future<String> getUserEmail() async {
    String email = '';
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.email!;
    }
    if (Platform.isWindows) {
      return await getEmailFromConnectedDevice();
    }
    return email;
  }

  static Future<void> addTokenToNewUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String premiumUserMD5 = Md5Generator.composeMd5IdForFirebaseDbPremium(
        userEmail: currentUser!.email!);
    final dataTrack = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.premium)
        .doc(premiumUserMD5);
    final documentSnapshot = await dataTrack.get();

    if (!documentSnapshot.exists) {
      _instance._setToken(100);
    }
  }

  Future<void> _setToken(int token) async {
    String? email = await getUserEmail();
    if (email.isNotEmpty) {
      String premiumUserMD5 =
          Md5Generator.composeMd5IdForFirebaseDbPremium(userEmail: email);

      final dataTrack = FirebaseFirestore.instance
          .collection(FirebaseConstant.firestore.premium)
          .doc(premiumUserMD5);
      final tokenData = {
        'token': token.toString(),
      };
      await dataTrack.set(tokenData);
    }
  }

  Future<void> _addToken(int additionalValue) async {
    var currentToken = await _getToken();
    var newTokenValue = currentToken + additionalValue;
    _setToken(newTokenValue);
  }

  Future<void> _reduceToken(int byValue) async {
    var currentToken = await _getToken();
    var newTokenValue = 0;
    if (currentToken > byValue) {
      newTokenValue = currentToken - byValue;
    }
    _setToken(newTokenValue);
  }
}
