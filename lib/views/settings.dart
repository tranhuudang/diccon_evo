import 'dart:io';

import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubits/setting_cubit.dart';
import '../global.dart';
import '../models/setting.dart';
import '../models/user_info.dart';
import '../services/auth_service.dart';
import '../views/components/setting_section.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        icon: Icons.settings,
        title: "Settings",
      ),
      body: BlocBuilder<SettingCubit, Setting>(builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                SettingSection(title: 'Dictionary Section', children: [
                  Row(children: [
                    const Text("Number of synonyms"),
                    const SizedBox(
                      width: 8,
                    ),
                    DropdownButton<int>(
                      focusColor: Colors.white,
                      value: state.numberOfSynonyms,
                      hint: const Text('Select a number'),
                      onChanged: (int? newValue) {
                        context
                            .read<SettingCubit>()
                            .setNumberOfSynonyms(newValue!);
                      },
                      items: [
                        DropdownMenuItem<int>(
                          value: 10,
                          child: Text(10.toString()),
                        ),
                        DropdownMenuItem<int>(
                          value: 20,
                          child: Text(20.toString()),
                        ),
                        DropdownMenuItem<int>(
                          value: 30,
                          child: Text(30.toString()),
                        ),
                      ],
                    ),
                  ]),
                  Row(children: [
                    const Text("Number of antonyms"),
                    const SizedBox(
                      width: 8,
                    ),
                    DropdownButton<int>(
                      focusColor: Colors.white,
                      value: state.numberOfAntonyms,
                      hint: const Text('Select a number'),
                      onChanged: (int? newValue) {
                        context
                            .read<SettingCubit>()
                            .setNumberOfAntonyms(newValue!);
                      },
                      items: [
                        DropdownMenuItem<int>(
                          value: 10,
                          child: Text(10.toString()),
                        ),
                        DropdownMenuItem<int>(
                          value: 20,
                          child: Text(20.toString()),
                        ),
                        DropdownMenuItem<int>(
                          value: 30,
                          child: Text(30.toString()),
                        ),
                      ],
                    ),
                  ])
                ]),
                SettingSection(
                  title: 'Reading Section',
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.text_increase),
                        Slider(
                            min: 0.1,
                            value: state.readingFontSize! / 70,
                            onChanged: (newValue) {
                              context
                                  .read<SettingCubit>()
                                  .setReadingFontSize(newValue * 70);
                            }),
                      ],
                    ),
                    Text(
                      "Sample text that will be displayed on Reading.",
                      style: TextStyle(fontSize: state.readingFontSize),
                    )
                  ],
                ),
                const SettingSection(
                  title: "About",
                  children: [
                    Row(
                      children: [
                        Text("Diccon Evo", style: TextStyle()),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("© 2023 Zeroboy. All rights reserved."),
                        Spacer(),
                        Text("v88"),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    const Text(
                      "Available at",
                      style: TextStyle(
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
