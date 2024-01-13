import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class PlanButton extends StatelessWidget {
  const PlanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(16)),
      child: Text(
        "BETA",
        style: TextStyle(color: context.theme.colorScheme.onSecondary),
      ),
    );
  }
}
