import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/presentation/settings/ui/screens/purchase.dart';
import 'package:flutter/foundation.dart';

class PlanButton extends StatelessWidget {
  const PlanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var token = Tokens.token;
    return Row(
      children: [
        FutureBuilder(
            future: token,
            builder: (context, tokenSnapshot) {
              if (tokenSnapshot.hasData) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InAppPurchaseView()));
                  },
                  child: Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: tokenSnapshot.data! > 100
                          ? Colors.amber
                          : context.theme.colorScheme.secondary.withOpacity(.5),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      tokenSnapshot.data! > 100 ? "Premium" : "Free".i18n,
                      style:
                          TextStyle(color: context.theme.colorScheme.onSecondary),
                    ),
                  ),
                                ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: SizedBox(
                      height: 18, width: 18,
                      child: CircularProgressIndicator()),
                );
              }
            }),
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
