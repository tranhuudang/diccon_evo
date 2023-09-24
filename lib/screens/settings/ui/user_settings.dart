import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/settings/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../data/data_providers/notify.dart';
import '../../commons/header.dart';
import '../../commons/pill_button.dart';
import 'components/available_box.dart';
import 'components/setting_section.dart';

class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  @override
  Widget build(BuildContext context) {
    var userBloc = context.read<UserBloc>();
    userBloc.add(UserLoginEvent());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<UserBloc, UserState>(
              listenWhen: (previous, current) => current is UserActionState,
              buildWhen: (previous, current) => current is! UserActionState,
              listener: (context, state) {
                if (state is UserLoggingoutState) {
                  Notify.showLoadingAlertDialog(context, "Logging out".i18n,
                      "Your data will be cleared during the process.".i18n);
                } else if (state is UserLogoutCompletedState) {
                  Navigator.pop(context);
                  Notify.showSnackBar(context, "You are logged out");
                }
                if (state is UserSyncCompleted) {
                  Notify.showSnackBar(context, "Your data is synced");
                }
              },
              builder: (context, state) {
                if (state is UserLoginState) {
                  var userLoginState = state;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Header
                      Header(title: "Account".i18n),
                      const SizedBox().mediumHeight(),

                      /// Login form and user infomations
                      SettingSection(
                        title: "User".i18n,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              userLoginState.userInfo.avatarUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image(
                                        height: 70,
                                        width: 70,
                                        image: NetworkImage(
                                            userLoginState.userInfo.avatarUrl),
                                        fit: BoxFit
                                            .cover, // Use BoxFit.cover to ensure the image fills the rounded rectangle
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userLoginState.userInfo.name,
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
                                  icon: UniconsLine.trash,
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
                  );
                } else {
                  return UninitializedView(userBloc: userBloc);
                }
              },
            ),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Header
        Header(title: "Account".i18n),
        const SizedBox().mediumHeight(),

        /// Login form and user infomations
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
        const SizedBox(
          height: 30,
        ),
        const AvailableBox(),
      ],
    );
  }
}
