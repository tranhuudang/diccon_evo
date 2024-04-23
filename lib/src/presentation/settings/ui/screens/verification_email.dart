import 'dart:async';

import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerificationEmailView extends StatefulWidget {
  const VerificationEmailView({super.key});

  @override
  State<VerificationEmailView> createState() => _VerificationEmailViewState();
}

class _VerificationEmailViewState extends State<VerificationEmailView> {
  late Timer timer;

  @override
  void initState(){
    super.initState();
    checkingEmailVerification();
  }

  void checkingEmailVerification(){
      timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (kDebugMode) {
          print('Waiting for email verification');
        }
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseAuth.instance.currentUser?.reload();
          bool? isEmailVerified = FirebaseAuth.instance.currentUser
              ?.emailVerified;
          if (isEmailVerified == true) {
            if (kDebugMode) {
              print('Email is verified.');
            }
            await Tokens.addTokenToNewUser();
            timer.cancel();
            context.pushNamed(RouterConstants.home);
          }
        }
      });
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email address verification'.i18n),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('A verification email is sent to ${FirebaseAuth.instance.currentUser?.email}.'
                ' Kindly review your inbox or spam folder to confirm the authenticity of your email.'),
          ],
        ),
      ),
    );
  }
}
