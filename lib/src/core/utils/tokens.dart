import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../configs/configs.dart';

class Tokens {
  Tokens._();
  static final Tokens _instance = Tokens._();

  int _tokens = -1;

  static Future<int> get token async {
    if (_instance._tokens == -1) {
      await _instance._getToken();
    }
    return _instance._tokens;
  }

  static setToken({required int toValue}) async {
    _instance._tokens = toValue;
    await _instance._setToken(toValue);
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
    String premiumUserMD5 =
        _composeMd5IdForFirebaseDbPremium(userEmail: currentUser!.email!);
    final dataTrack =
        FirebaseFirestore.instance.collection("Premium").doc(premiumUserMD5);
    await dataTrack.get().then((snapshot) {
      if (snapshot.exists) {
        _tokens = snapshot.data()?["token"];
        print('hihihihi');
        print(_tokens);
        return _tokens.toInt();
      }
    });
    return -1;
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
}
