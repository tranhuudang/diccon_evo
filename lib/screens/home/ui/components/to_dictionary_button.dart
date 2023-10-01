import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../dictionary/ui/dictionary.dart';

class ToDictionaryButton extends StatelessWidget {
  const ToDictionaryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const DictionaryView()));
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 8, right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(32,),
              bottomRight: Radius.circular(32,)
          ),
        ),
        child: Row(
          children: [
            Text("Dictionary".i18n),
          ],
        ),
      ),
    );
  }
}