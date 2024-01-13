import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/settings/ui/screens/verification_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'.i18n),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Diccon Account allows to sync your data across your devices.'
                .i18n),
            16.height,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text('Email'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address'.i18n;
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Your email is not valid'.i18n;
                      }
                      return null;
                    },
                  ),
                  8.height,
                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text('Password'.i18n),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Please enter your password having at least 6 characters'
                            .i18n;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            16.height,
            FilledButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (FirebaseAuth.instance.currentUser != null) {
                      await FirebaseAuth.instance.currentUser
                          !.sendEmailVerification();
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationEmailView()));
                  }

                },
                child: Text('Create new account'.i18n)),
          ],
        ),
      ),
    );
  }
}
