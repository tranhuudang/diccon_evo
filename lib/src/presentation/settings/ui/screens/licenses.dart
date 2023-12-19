import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'license_reading.dart';

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
