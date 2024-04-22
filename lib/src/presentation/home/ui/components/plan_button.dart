import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';

class PlanButton extends StatelessWidget {
  const PlanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: false
                  ? Colors.amber
                  : context.theme.colorScheme.secondary.withOpacity(.5),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(
              false ? "Premium" : "BETA".i18n,
              style: TextStyle(color: context.theme.colorScheme.onSecondary),
            ),
          ),
        ),
        4.width,
        if (kDebugMode)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                color: context.theme.colorScheme.secondary.withOpacity(.5),
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(
                "B",
                style: TextStyle(color: context.theme.colorScheme.onSecondary),
              ),
            ),
          )
      ],
    );
  }
}
