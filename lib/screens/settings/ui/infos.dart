import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:flutter/material.dart';
import '../../../config/properties.dart';
import 'components/setting_section.dart';
import 'components/store_badge.dart';

class InfosView extends StatefulWidget {
  const InfosView({super.key});

  @override
  State<InfosView> createState() => _InfosViewState();
}

class _InfosViewState extends State<InfosView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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

            /// Header
            Header(
              title: "About".i18n,
            ),
          ],
        ),
      ),
    );
  }
}
