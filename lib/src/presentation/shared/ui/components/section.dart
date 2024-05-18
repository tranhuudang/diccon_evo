import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class Section extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const Section({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title ?? '',
                style: context.theme.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.primary),
              ),
            ),
            16.height,
            Column(
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
