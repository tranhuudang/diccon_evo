import 'package:diccon_evo/src/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../presentation.dart';

class YourIdSection extends StatefulWidget {
  const YourIdSection({
    super.key,
  });

  @override
  State<YourIdSection> createState() => _YourIdSectionState();
}

class _YourIdSectionState extends State<YourIdSection> {
  String yourId = '';

  _getYourId() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      setState(() {
        yourId = userId;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getYourId();
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Your Id'.i18n,
      children: [
        TextButton.icon(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: yourId));
            },
            label: Text(yourId)),
      ],
    );
  }
}
