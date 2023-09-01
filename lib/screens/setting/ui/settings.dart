import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/circle_button.dart';
import '../cubit/setting_cubit.dart';
import '../../../config/properties.dart';
import '../../../models/setting.dart';
import 'setting_section.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<SettingCubit, Setting>(builder: (context, state) {
          SettingCubit settingCubit = context.read<SettingCubit>();
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultTargetPlatform.isMobile()
                          ? Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CircleButton(
                                iconData: Icons.arrow_back,
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                          )
                          : const SizedBox.shrink(),
                      Text("Settings".i18n,
                          style: const TextStyle(fontSize: 28))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  /// Login form and user infomations
                  // Platform.isAndroid
                  //     ? SettingSection(title: "User", children: [
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: Global.userInfo.avatarUrl != ""
                  //                   ? BorderRadius.circular(50.0)
                  //                   : BorderRadius.circular(0),
                  //               child: Global.userInfo.avatarUrl != ""
                  //                   ? Image(
                  //                       height: 70,
                  //                       width: 70,
                  //                       image: NetworkImage(
                  //                           Global.userInfo.avatarUrl),
                  //                       fit: BoxFit
                  //                           .cover, // Use BoxFit.cover to ensure the image fills the rounded rectangle
                  //                     )
                  //                   : const Align(
                  //                       alignment: Alignment.center,
                  //                       child: Text(
                  //                         "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices",
                  //                         style: TextStyle(fontSize: 16),
                  //                         textAlign: TextAlign.center,
                  //                       ),
                  //                     ),
                  //             ),
                  //             Global.userInfo.name != ""
                  //                 ? Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       Global.userInfo.name,
                  //                       style: const TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   )
                  //                 : Container(),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               Global.userInfo.email,
                  //               style: const TextStyle(color: Colors.black26),
                  //             ),
                  //           ],
                  //         ),
                  //         Global.userInfo.id != ""
                  //             ? Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   ElevatedButton(
                  //                     onPressed: () {},
                  //                     child: const Text("Sync your data"),
                  //                   ),
                  //                   const SizedBox(
                  //                     width: 8,
                  //                   ),
                  //                   ElevatedButton(
                  //                     onPressed: () {
                  //                       AuthService authService = AuthService();
                  //                       authService.googleSignOut();
                  //                       setState(() {
                  //                         Global.userInfo =
                  //                             UserInfo("", "", "", "");
                  //                       });
                  //                     },
                  //                     child: const Text("Log out"),
                  //                   ),
                  //                 ],
                  //               )
                  //             : GoogleSignInButton(
                  //                 onPressed: () async {
                  //                   AuthService authService = AuthService();
                  //                   GoogleSignInAccount? user =
                  //                       await authService.googleSignIn();
                  //                   setState(() {
                  //                     Global.userInfo = UserInfo(
                  //                         user!.id,
                  //                         user.displayName ?? "",
                  //                         user.photoUrl ?? "",
                  //                         user.email);
                  //                   });
                  //                 },
                  //               ),
                  //       ])
                  //     : Container(),
                  SettingSection(
                    title: 'Dictionary Section'.i18n,
                    children: [
                      Row(children: [
                        Text("Number of synonyms".i18n),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: 60,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(16),
                                focusColor: Colors.white,
                                value: state.numberOfSynonyms,
                                hint: Text('Select a number'.i18n),
                                onChanged: (int? newValue) {
                                  settingCubit.setNumberOfSynonyms(newValue!);
                                },
                                items: [5, 10, 20, 30]
                                    .map((value) => DropdownMenuItem<int>(
                                  alignment: Alignment.center,
                                          value: value,
                                          child: Text(value.toString()),
                                        ))
                                    .toList()),
                          ),
                        ),
                      ]),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          Text("Number of antonyms".i18n),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: 60,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                alignment: Alignment.center,
                                  borderRadius: BorderRadius.circular(16),
                                  isExpanded: true,
                                  focusColor: Colors.white,
                                  value: state.numberOfAntonyms,
                                  hint: Text('Select a number'.i18n),
                                  onChanged: (int? newValue) {
                                    settingCubit.setNumberOfAntonyms(newValue!);
                                  },
                                  items: [5, 10, 20, 30]
                                      .map((value) => DropdownMenuItem<int>(
                                    alignment: Alignment.center,
                                            value: value,
                                            child: Text(value.toString()),
                                          ))
                                      .toList()),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SettingSection(
                    title: "About".i18n,
                    children: [
                      const Row(
                        children: [
                          Text("Diccon", style: TextStyle()),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text("© 2023 Zeroboy."),
                              const SizedBox(width: 5),
                              Text("All rights reserved.".i18n),
                            ],
                          ),
                          const Spacer(),
                          Text(Properties.version),
                        ],
                      )
                    ],
                  ),
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
          );
        }),
      ),
    );
  }

  Widget playStoreBadge() {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(
            'https://play.google.com/store/apps/details?id=com.zeroboy.diccon_evo');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      }, // Replace with your image path

      child: Image.asset(
        "assets/badges/en_badge_web_generic.png",
      ),
    );
  }

  Widget amazonStoreBadge() {
    return InkWell(
      onTap: () async {
        final Uri url =
            Uri.parse('https://www.amazon.com/dp/B0CBP3XSQJ/ref=apps_sf_sta');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      }, // Replace with your image path

      child: Image.asset(
        "assets/badges/amazon-appstore-badge-english-white.png",
      ),
    );
  }

  Widget microsoftStoreBadge() {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(
            'https://apps.microsoft.com/store/detail/diccon-evo/9NPF4HBMNG5D');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      }, // Replace with your image path

      child: SvgPicture.asset(
        "assets/badges/ms-en-US-dark.svg",
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
            const Text("Continue with Google"),
          ],
        ));
  }
}
