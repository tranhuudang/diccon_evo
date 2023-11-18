import 'package:diccon_evo/src/common/constants/licences.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';

import 'license_reading.dart';
import 'licenses.dart';

class LicensesView extends StatefulWidget {
  const LicensesView({super.key});

  @override
  State<LicensesView> createState() => _LicensesViewState();
}

class _LicensesViewState extends State<LicensesView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 60),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ossLicenses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ossLicenses[index].name),
                      subtitle: Text(ossLicenses[index].version),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LicenseReadingView(
                              licenseName: ossLicenses[index].name,
                              licenseDescription:
                                  ossLicenses[index].description,
                              licenseVersion: ossLicenses[index].version,
                              license: ossLicenses[index].license ?? '',
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),

            /// Header
            Header(
              title: "Licenses".i18n,
            ),
          ],
        ),
      ),
    );
  }
}
