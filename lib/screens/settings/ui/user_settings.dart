import 'package:diccon_evo/screens/settings/ui/components/store_badge.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../config/local_traditions.dart';
import '../../../models/user_info.dart';
import '../../../services/auth_service.dart';
import '../../commons/circle_button.dart';
import '../../../config/properties.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CircleButton(
                          iconData: Icons.arrow_back,
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Text("Account".i18n, style: const TextStyle(fontSize: 28))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                /// Login form and user infomations
                defaultTargetPlatform.isAndroid()
                    ? SettingSection(title: "User".i18n, children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: Properties.userInfo.avatarUrl != ""
                                  ? BorderRadius.circular(50.0)
                                  : BorderRadius.circular(0),
                              child: Properties.userInfo.avatarUrl != ""
                                  ? Image(
                                      height: 70,
                                      width: 70,
                                      image: NetworkImage(
                                          Properties.userInfo.avatarUrl),
                                      fit: BoxFit
                                          .cover, // Use BoxFit.cover to ensure the image fills the rounded rectangle
                                    )
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices"
                                            .i18n,
                                        style: const TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                            Properties.userInfo.name != ""
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      Properties.userInfo.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Properties.userInfo.email,
                            ),
                          ],
                        ),
                        Tradition.heightSpacer,
                        Properties.userInfo.id != ""
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PillButton(onTap: (){}, title: "Sync your data"),
                                  Tradition.widthSpacer,
                                  PillButton(
                                    onTap: () {
                                      AuthService authService = AuthService();
                                      authService.googleSignOut();
                                      setState(() {
                                        Properties.userInfo =
                                            UserInfo("", "", "", "");
                                      });
                                    },
                                    title: "Log out",
                                  ),
                                ],
                              )
                            : GoogleSignInButton(
                                onPressed: () async {
                                  AuthService authService = AuthService();
                                  GoogleSignInAccount? user =
                                      await authService.googleSignIn();
                                  setState(() {
                                    Properties.userInfo = UserInfo(
                                        user!.id,
                                        user.displayName ?? "",
                                        user.photoUrl ?? "",
                                        user.email);
                                  });
                                },
                              ),
                      ])
                    : Container(),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Available at".i18n,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 200,
                      width: 370,
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: [
                          microsoftStoreBadge(),
                          amazonStoreBadge(),
                          playStoreBadge(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final Function()? onPressed;
  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              padding: const EdgeInsets.all(3),
              color: Colors.white,
              child: const Image(
                height: 20,
                image: AssetImage("assets/google.svg"),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text("Continue with Google".i18n),
        ],
      ),
    );
  }
}
