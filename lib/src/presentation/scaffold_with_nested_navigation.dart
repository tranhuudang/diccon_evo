import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:unicons/unicons.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNestedNavigation({
    super.key,
    required this.navigationShell,
  });
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (context) {
      return const HomeView();
    }, tablet: (context) {
      return Scaffold(
        body: Row(
          children: [
            // Fixed navigation rail on the left (start)
            NavigationRail(
              leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {

                  }),
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
              labelType: NavigationRailLabelType.selected,
              destinations: [
                NavigationRailDestination(
                    icon: const Icon(Icons.search),
                    label: Text('Dictionary'.i18n)),
                NavigationRailDestination(
                    icon: const Icon(UniconsLine.books),
                    selectedIcon: const Icon(UniconsLine.book_open),
                    label: Text('Library'.i18n)),
                NavigationRailDestination(
                  icon: const FaIcon(FontAwesomeIcons.comments),
                  selectedIcon: const FaIcon(FontAwesomeIcons.solidComments),
                  label: Text('Conversation'.i18n),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.directions_run_outlined),
                  selectedIcon: const Icon(Icons.directions_run),
                  label: Text('Practice'.i18n),
                ),
              ],
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              context.pushNamed(RouterConstants.infos);
                            }),
                        const SizedBox(
                            width: 50,
                            child: WaveDivider(thickness: .3,)),
                        IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () {
                              context.pushNamed(RouterConstants.commonSettings);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // Main content on the right (end)
            Expanded(
              child: navigationShell,
            ),
          ],
        ),
      );
    });
  }
}
