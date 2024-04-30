
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:diccon_evo/src/presentation/settings/ui/screens/purchase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:wave_divider/wave_divider.dart';

class MobileUserSettingsView extends StatefulWidget {
  const MobileUserSettingsView({super.key});

  @override
  State<MobileUserSettingsView> createState() => _MobileUserSettingsViewState();
}

class _MobileUserSettingsViewState extends State<MobileUserSettingsView> {
  @override
  Widget build(BuildContext context) {
    var token = Tokens.token;
    final userBloc = context.read<UserBloc>();
    userBloc.add(CheckIsSignedInEvent());
    var currentUser = FirebaseAuth.instance.currentUser;
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
                                        color: context
                                            .theme.colorScheme.onTertiary,
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
                        16.height,
                        FutureBuilder(
                            future: token,
                            builder: (context, tokenSnapshot) {
                              if (tokenSnapshot.hasData) {
                                return SizedBox(
                                  width: 64.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              icon: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'User type: '.i18n,
                                          ),
                                          Container(
                                            height: 24,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: tokenSnapshot.data! > 100
                                                    ? Colors.amber
                                                    : context.theme.colorScheme
                                                        .secondary
                                                        .withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Center(
                                              child: Text(
                                                tokenSnapshot.data! > 100
                                                    ? "Premium"
                                                    : "Free".i18n,
                                                style: TextStyle(
                                                    color: context
                                                        .theme
                                                        .colorScheme
                                                        .onSecondary),
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
                                      Center(
                                        child: FilledButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const InAppPurchaseView()));
                                            },
                                            child: Text('Upgrade'.i18n)),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator());
                              }
                            }),
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
                                    userBloc.add(MobileUserLogoutEvent()),
                                child: Text("Log out".i18n)),
                          ],
                        ),
                        30.height,
                        const WaveDivider(),
                        Column(
                          children: [
                            Text(
                              "Delete all your data on cloud.".i18n,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            8.height,
                            Text(
                                "(This process once fired will never be undone. Please take it serious.)"
                                    .i18n),
                            8.height,
                            FilledButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  userBloc.add(UserDeleteDateEvent());
                                },
                                child: Text(
                                  "Erase all".i18n,
                                  style: context.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
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