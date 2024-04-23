import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../configs/configs.dart';

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

  String _composeMd5IdForFirebaseDbPremium({required String userEmail}) {
    userEmail = userEmail.trim().toLowerCase();
    var composeString = userEmail + Env.premiumToken;
    var bytes = utf8.encode(composeString);
    var resultMd5 = md5.convert(bytes);
    return resultMd5.toString();
  }

  Future<int> _getToken() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String premiumUserMD5 =
          _composeMd5IdForFirebaseDbPremium(userEmail: currentUser.email!);
      final dataTrack =
          FirebaseFirestore.instance.collection("Premium").doc(premiumUserMD5);
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

  static Future<void> addTokenToNewUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String premiumUserMD5 = _instance._composeMd5IdForFirebaseDbPremium(
        userEmail: currentUser!.email!);
    final dataTrack =
        FirebaseFirestore.instance.collection("Premium").doc(premiumUserMD5);
    final documentSnapshot = await dataTrack.get();

    if (!documentSnapshot.exists) {
      _instance._setToken(100);
    }
  }

  Future<void> _setToken(int token) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String premiumUserMD5 =
        _composeMd5IdForFirebaseDbPremium(userEmail: currentUser!.email!);

    final dataTrack =
        FirebaseFirestore.instance.collection("Premium").doc(premiumUserMD5);
    final tokenData = {
      'token': token.toString(),
    };
    await dataTrack.set(tokenData);
  }

  Future<void> _addToken(int additionalValue) async {
    var currentToken = await _getToken();
    var newTokenValue = currentToken + additionalValue;
    _setToken(newTokenValue);
  }

  Future<void> _reduceToken(int byValue) async {
    var currentToken = await _getToken();
    var newTokenValue = 0;
    if (currentToken < byValue) {
      newTokenValue = 0;
    } else {
      newTokenValue = currentToken - byValue;
    }
    _setToken(newTokenValue);
  }
}
