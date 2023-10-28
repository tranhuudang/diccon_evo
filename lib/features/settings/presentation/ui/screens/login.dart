import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
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
            Center(
              child: SizedBox(
                //color: Colors.red,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 120,
                        child: Image(
                          image: AssetImage("assets/diccon-256.png"),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Simplifying",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Language Learning",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),

                      const SizedBox(
                        height: 16,
                      ),
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
                      const SizedBox(
                        height: 8,
                      ),
                      // TipsBox(children: [
                      // ]),
                      const Spacer(),
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
