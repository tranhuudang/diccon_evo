import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:unicons/unicons.dart';
import 'package:wave_divider/wave_divider.dart';

class SignInView extends StatefulWidget {
  final bool? isFromAccountPage;
  const SignInView({super.key, this.isFromAccountPage = false});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  User? _loggedInUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  User? _currentLoggedInUser() {
    // Check if user is still logged into device
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform.isAndroid()) {
      _loggedInUser = _currentLoggedInUser();
      if (_loggedInUser != null) {
        context.read<UserBloc>().add(GoogleLoginEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform.isAndroid()) {
      if (_loggedInUser == null) {
        return buildUserNotLoginYetWidget(context);
      } else {
        return const HomeView();
      }
    } else {
      return const HomeView();
    }
  }

  SafeArea buildUserNotLoginYetWidget(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: HeadSentence(
                              listText: ['Simplifying', 'Language Learning'])),
                      8.height,
                      /// Sub sentence
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 18),
                        child: Text(
                          "Introducing a cutting-edge chat-based dictionary, your instant language companion at your fingertips! Explore the world of words and definitions with ease, right in your chat window."
                              .i18n,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.colorScheme.onSurface),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email field
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                label: Text('Email'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address'.i18n;
                                }
                                if (!value.contains('@') ||
                                    !value.contains('.')) {
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                label: Text('Password'.i18n),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 6) {
                                  return 'Please enter your password having at least 6 characters'
                                      .i18n;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                            ),
                          )
                        ],
                      ),
                      FilledButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              if (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified ){
                                if (widget.isFromAccountPage!) {
                                  context.pop();
                                }
                                else {
                                  context.pushNamed(RouterConstants.home);
                                }
                              }
                            }
                          },
                          child: Text('Continues'.i18n)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?".i18n),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpView()));
                              },
                              child: Text('Sign up'.i18n)),
                        ],
                      ),
                      10.height,
                      WaveDivider(),
                      BlocListener<UserBloc, UserState>(
                          listenWhen: (previous, current) =>
                              current is UserActionState,
                          listener: (context, state) {
                            if (state is UserLoggedInSuccessfulState) {
                              if (widget.isFromAccountPage!) {
                                context.pop();
                              } else {
                                context
                                    .pushReplacementNamed(RouterConstants.home);
                              }
                            }
                          },
                          child: FilledButton.tonalIcon(
                            icon: const Icon(UniconsLine.google),
                            onPressed: () async {
                              userBloc.add(GoogleLoginEvent());
                            },
                            label: Text("Continue with Google".i18n),
                          )),
                      8.height,
                      FilledButton.tonal(
                          onPressed: () {
                            context.pushReplacementNamed(RouterConstants.home);
                          },
                          child: Text("Continue without login".i18n)),
                    ],
                  ),
                ),
              ),
            ),

            /// Menu
            const LoginMenu(),
          ],
        ),
      ),
    );
  }
}
