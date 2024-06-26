import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../../core/core.dart';
import '../../../presentation.dart';

class YourPeersTab extends StatelessWidget {
  const YourPeersTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'This tab provides a list of groups you are part of. You can create new groups, join existing ones, and chat with your peers.'
                .i18n),
        Row(
          children: [
            Expanded(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.primary, BlendMode.srcIn),
                child: Image(
                  image: AssetImage(LocalDirectory.textRecognizerIllustration),
                  height: 140,
                ),
              ),
            ),
            8.width,
            Expanded(
                flex: 3,
                child: Opacity(
                  opacity: .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Connect with your peers through group chats.".i18n),
                    ],
                  ),
                )),
          ],
        ),
        const WaveDivider(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          thickness: .3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton.tonalIcon(
                onPressed: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  final userId = auth.currentUser?.uid;
                  if (userId != null && userId.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GroupListScreen(
                                    userId: userId)));
                  }
                },
                icon: const Icon(Icons.group),
                label: Text('See your groups'.i18n)),
          ],
        )
      ],
    );
  }
}
