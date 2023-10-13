import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import '../../../data/data_providers/notify.dart';
import '../../commons/header.dart';
import '../../commons/pill_button.dart';
import 'components/setting_section.dart';

class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    userBloc.add(UserLoginEvent());
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
          listenWhen: (previous, current) => current is UserActionState,
          buildWhen: (previous, current) => current is! UserActionState,
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserLoggingoutState:
                Notify.showLoadingAlertDialog(
                    context: context,
                    title: "Logging out".i18n,
                    content:
                        "Your data will be cleared during the process.".i18n);
                break;
              case UserLogoutCompletedState:
                Navigator.pop(context);
                Notify.showSnackBar(
                    context: context, content: "You are logged out");
                break;
              case UserSyncCompleted:
                Notify.showSnackBar(
                    context: context, content: "Your data is synced");
                break;
              case NoInternetState:
                Notify.showAlertDialogWithoutAction(
                    context: context,
                    title: "You're not connected".i18n,
                    content: "SubSentenceInNoInternetBubble".i18n);
                break;
            }
          },
          builder: (context, state) {
            if (state is UserLoginState) {
              var userLoginState = state;
              return Stack(
                children: [
                  /// Login form and user infomations
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
                    child: Column(
                      children: [
                        SettingSection(
                          title: "User".i18n,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                userLoginState.userInfo.photoURL.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image(
                                          height: 70,
                                          width: 70,
                                          image: NetworkImage(userLoginState
                                              .userInfo.photoURL),
                                          fit: BoxFit
                                              .cover, // Use BoxFit.cover to ensure the image fills the rounded rectangle
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userLoginState.userInfo.displayName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              userLoginState.userInfo.email,
                            ),
                            const SizedBox().mediumHeight(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PillButton(
                                    icon: Icons.sync,
                                    isDisabled: userLoginState.isSyncing,
                                    onTap: () => userBloc.add(UserSyncEvent(
                                        userInfo: userLoginState.userInfo)),
                                    title: "Sync your data"),
                                const SizedBox().mediumWidth(),
                                PillButton(
                                  onTap: () => userBloc.add(UserLogoutEvent()),
                                  title: "Log out",
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Divider(),
                            Column(
                              children: [
                                Text(
                                  "Delete all your data on cloud.".i18n,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox().mediumHeight(),
                                Text(
                                    "(This process once fired will never be undone. Please take it serious.)"
                                        .i18n),
                                const SizedBox().mediumHeight(),
                                PillButton(
                                    icon: Icons.delete_outline,
                                    backgroundColor: Colors.red,
                                    onTap: () {
                                      userBloc.add(UserDeleteDateEvent());
                                    },
                                    title: "Erase all"),
                              ],
                            ),

                            /// Loading Indicator for syncing process
                            userLoginState.isSyncing
                                ? Column(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: LinearProgressIndicator(),
                                      ),
                                      Text("Your data is syncing..".i18n),
                                      const SizedBox().mediumHeight(),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Header
                  Header(title: "Account".i18n),
                ],
              );
            } else {
              return UninitializedView(userBloc: userBloc);
            }
          },
        ),
      ),
    );
  }
}

class UninitializedView extends StatelessWidget {
  const UninitializedView({
    super.key,
    required this.userBloc,
  });

  final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Login form and user infomations
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
          child: Column(
            children: [
              SettingSection(
                title: "User".i18n,
                children: [
                  Text(
                    "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices"
                        .i18n,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox().mediumHeight(),
                  PillButton(
                      icon: FontAwesomeIcons.google,
                      onTap: () async => userBloc.add(UserLoginEvent()),
                      title: "Continue with Google"),
                ],
              ),
            ],
          ),
        ),

        /// Header
        Header(title: "Account".i18n),
      ],
    );
  }
}
