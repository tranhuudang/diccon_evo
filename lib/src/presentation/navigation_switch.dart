import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationSwitchView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationSwitchView({
    super.key,
    required this.navigationShell,
  });

  @override
  State<NavigationSwitchView> createState() => _NavigationSwitchViewState();
}

class _NavigationSwitchViewState extends State<NavigationSwitchView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return const MobileHomeView();
      },
      tablet: (context) {
        return DesktopHomeView(navigationShell: widget.navigationShell);
      },
    );
  }
}
