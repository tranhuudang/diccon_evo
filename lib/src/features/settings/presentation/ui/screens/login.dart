import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  User? _loggedInUser;
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
        context.read<UserBloc>().add(UserLoginEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform.isAndroid()) {
      //if (_loggedInUser == null) {
      if (false) {
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
                      const SizedBox(
                        height: 16,
                      ),

                      /// Sub sentence
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 18),
                        child: Text(
                          "Introducing a cutting-edge chat-based dictionary, your instant language companion at your fingertips! Explore the world of words and definitions with ease, right in your chat window."
                              .i18n,
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: context.theme.colorScheme.onSurface),
                        ),
                      ),
                      const SizedBox(height: 70,),
                      BlocListener<UserBloc, UserState>(
                          listenWhen: (previous, current) =>
                              current is UserActionState,
                          listener: (context, state) {
                            if (state is UserLoggedInSuccessfulState) {
                              context
                                  .pushReplacementNamed(RouterConstants.home);
                            }
                          },
                          child: FilledButton(
                            onPressed: () async {
                              userBloc.add(UserLoginEvent());
                            },
                            child: Text("Continue with Google".i18n),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      FilledButton.tonal(
                          onPressed: () {
                            context.pushReplacementNamed(RouterConstants.home);
                          },
                          child: Text("Continue without login".i18n)),
                      const SizedBox(height: 50,),
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
