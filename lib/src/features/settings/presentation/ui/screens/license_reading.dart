import 'package:diccon_evo/src/common/constants/licences.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
import 'package:wave_divider/wave_divider.dart';

import 'licenses.dart';

class LicenseReadingView extends StatelessWidget {
  final String licenseName;
  final String licenseDescription;
  final String licenseVersion;
  final String license;
  const LicenseReadingView(
      {super.key,
      required this.licenseName,
      required this.licenseDescription,
      required this.licenseVersion,
      required this.license});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 70, right: 16, bottom: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(licenseVersion),
                  Text(licenseDescription),
                  const WaveDivider(thickness: .3,),
                  Text(license),
                ],
              ),
            ),

            /// Header
            Header(
              title: licenseName,
            ),
          ],
        ),
      ),
    );
  }
}
