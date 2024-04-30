import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:diccon_evo/src/presentation/settings/bloc/user_bloc.dart';
import 'package:diccon_evo/src/presentation/settings/ui/screens/connect_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_divider/wave_divider.dart';

class DesktopUserSettingsView extends StatefulWidget {
  const DesktopUserSettingsView({super.key});

  @override
  State<DesktopUserSettingsView> createState() =>
      _DesktopUserSettingsViewState();
}

class _DesktopUserSettingsViewState extends State<DesktopUserSettingsView> {
  late Future<String> syncUserId;

  Future<String> checkIfConnectedWithMobile() async {
    final code = await Md5Generator.composeMD5IdForFirebaseDbDesktopLogin();
    final dataTrack = FirebaseFirestore.instance.collection("Login").doc(code);
    final documentSnapshot = await dataTrack.get();

    if (documentSnapshot.exists) {
      var userId = documentSnapshot.data()?["userEmail"];
      return userId;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    syncUserId = checkIfConnectedWithMobile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: syncUserId,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! != '') {
              return UserSettingsView(syncUserId: snapshot.data!);
            } else {
              return const ConnectAccountView();
            }
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Account'.i18n),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }
}

class UserSettingsView extends StatefulWidget {
  final String syncUserId;
  const UserSettingsView({super.key, required this.syncUserId});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  @override
  Widget build(BuildContext context) {
    var token = Tokens.token;
    final userBloc = context.read<UserBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'.i18n),
      ),
      body: BlocListener(
        listener: (BuildContext context, state) {
          if (state is DesktopUserLogoutCompletedEvent) {
            context.pop();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: token,
                builder: (context, tokenSnapshot) {
                  if (tokenSnapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 70.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    'Tokens: ${tokenSnapshot.data.toString()}'),
                                IconButton(
                                    onPressed: () {
                                      context.showAlertDialogWithoutAction(
                                          title: 'Tokens'.i18n,
                                          content:
                                              'This tokens will be used on Conversation or other premium functions.'
                                                  .i18n);
                                    },
                                    icon: const Icon(Icons.info_outline))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'User type: '.i18n,
                                ),
                                Container(
                                  height: 24,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: tokenSnapshot.data! > 100
                                          ? Colors.amber
                                          : context.theme.colorScheme.secondary
                                              .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Text(
                                      tokenSnapshot.data! > 100
                                          ? "Premium"
                                          : "Free".i18n,
                                      style: TextStyle(
                                          color: context
                                              .theme.colorScheme.onSecondary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            8.height,
                            Text(
                                'Upgrade to our premium features for an enhanced dictionary experience. Unlock exclusive tools and resources to enrich your language journey today!'
                                    .i18n),
                            8.height,
                            const WaveDivider(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            16.height,
            FilledButton(
                onPressed: () => userBloc.add(UserSyncEvent()),
                child: Text("Sync your data".i18n)),
            16.height,
            FilledButton.tonal(
                onPressed: () {
                  userBloc.add(DesktopUserLogoutEvent());
                },
                child: Text("Log out".i18n)),
          ],
        ),
      ),
    );
  }
}
