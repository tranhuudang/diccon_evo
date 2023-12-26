import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class PillButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final String title;
  final bool? isDisabled;
  final Color? backgroundColor;
  final Color? color;

  const PillButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.icon,
      this.isDisabled = false,
      this.backgroundColor,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled! ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: isDisabled!
                ? context.theme.highlightColor
                : backgroundColor ?? context.theme.colorScheme.primary),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                color: context.theme.colorScheme.onPrimary,
                icon,
                size: 18,
              ),
            if (icon != null) 8.height,
            Text(
              title.i18n,
              style: TextStyle(
                  color: color ?? context.theme.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
