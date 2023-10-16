import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/home/ui/home.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../config/route_constants.dart';
import '../../commons/pill_button.dart';
import 'components/login_menu.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    if (defaultTargetPlatform.isAndroid()) {
      if (_loggedInUser == null) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
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
                            child: PillButton(
                                icon: FontAwesomeIcons.google,
                                onTap: () async {
                                  userBloc.add(UserLoginEvent());
                                },
                                title: "Continue with Google".i18n),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          PillButton(
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              color: Theme.of(context).colorScheme.onSecondary,
                              onTap: () {
                                context
                                    .pushReplacementNamed(RouterConstants.home);
                              },
                              title: "Continue without login".i18n,),
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
      } else {
        //userBloc.add(UserLoginEvent());
        return const HomeView();
      }
    } else {
      return const HomeView();
    }
  }
}
