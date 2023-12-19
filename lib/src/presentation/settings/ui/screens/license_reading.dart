import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:wave_divider/wave_divider.dart';

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
