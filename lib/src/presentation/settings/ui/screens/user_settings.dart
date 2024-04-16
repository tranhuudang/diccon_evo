import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:wave_divider/wave_divider.dart';

class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    userBloc.add(CheckIsSignedInEvent());
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: AppBar(
        title: Text("Account".i18n),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listenWhen: (previous, current) => current is UserActionState,
        buildWhen: (previous, current) => current is! UserActionState,
        listener: (context, state) {
          switch (state) {
            case UserLoggingOutState _:
              context.showLoadingAlertDialog(
                  title: "Logging out".i18n,
                  content:
                      "Your data will be cleared during the process.".i18n);
              break;
            case UserLogoutCompletedState _:
              Navigator.pop(context);
              context.showSnackBar(content: "You are logged out");
              break;
            case UserSyncCompleted _:
              context.showSnackBar(content: "Your data is synced");
              break;
            case NoInternetState _:
              context.showAlertDialogWithoutAction(
                  title: "You're not connected".i18n,
                  content: "SubSentenceInNoInternetBubble".i18n);
              break;
          }
        },
        builder: (context, state) {
          switch (state) {
            case UserLoginState _:
              var userLoginState = state;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Section(
                      title: "User".i18n,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (currentUser?.photoURL != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image(
                                  height: 70,
                                  width: 70,
                                  image:
                                  NetworkImage(currentUser!.photoURL ?? ''),
                                  fit: BoxFit
                                      .cover, // Use BoxFit.cover to ensure the image fills the rounded rectangle
                                ),
                              ),
                            if (currentUser?.photoURL == null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: context.theme.colorScheme.tertiary,
                                      child: Icon(
                                        Icons.person,
                                        size: 38,
                                        color:
                                        context.theme.colorScheme.onTertiary,
                                      ),
                                    )),
                              ),
                            if (currentUser?.displayName != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  currentUser?.displayName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          currentUser?.email ?? '',
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                onPressed: () => userBloc.add(UserSyncEvent()),
                                child: Text("Sync your data".i18n)),
                            8.width,
                            FilledButton.tonal(
                                onPressed: () =>
                                    userBloc.add(UserLogoutEvent()),
                                child: Text("Log out".i18n)),
                          ],
                        ),
                        30.height,
                        const WaveDivider(),
                        Column(
                          children: [
                            Text(
                              "Delete all your data on cloud.".i18n,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            8.height,
                            Text(
                                "(This process once fired will never be undone. Please take it serious.)"
                                    .i18n),
                            8.height,
                            FilledButton(
                                onPressed: () {
                                  userBloc.add(UserDeleteDateEvent());
                                },
                                child: Text("Erase all".i18n)),
                          ],
                        ),

                        /// Loading Indicator for syncing process
                        if (userLoginState.isSyncing)
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: LinearProgressIndicator(),
                              ),
                              Text("Your data is syncing..".i18n),
                              8.height,
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              );
            default:
              return UninitializedView(userBloc: userBloc);
          }
        },
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Section(
            title: "User".i18n,
            children: [
              Text(
                "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices"
                    .i18n,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              8.height,
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SignInView(isFromAccountPage: true)));
                  },
                  child: Text("Sign in/up".i18n))
            ],
          ),
        ],
      ),
    );
  }
}
