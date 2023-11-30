import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:unicons/unicons.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:window_manager/window_manager.dart';

class NavigationSwitchView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationSwitchView({
    super.key,
    required this.navigationShell,
  });

  @override
  State<NavigationSwitchView> createState() => _NavigationSwitchViewState();
}

class _NavigationSwitchViewState extends State<NavigationSwitchView>
    with WindowListener {
  bool _isTabletExpanded = false;
  bool _isDesktopExpanded = true;
  Timer? _saveWindowsSizeTimer;

  // Using navigationShell to go to different branches using provided index
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: true,
    );
  }

  // Detect when windows is changing size and save windows size
  @override
  void onWindowResize() async {
    // delay before save data
    if (_saveWindowsSizeTimer?.isActive ?? false) {
      _saveWindowsSizeTimer?.cancel();
    }
    _saveWindowsSizeTimer = Timer(const Duration(seconds: 3), () async {
      Size windowsSize = await WindowManager.instance.getSize();
      // Save windows size to setting
      final newSettings = Properties.instance.settings.copyWith(
          windowsWidth: windowsSize.width, windowsHeight: windowsSize.height);
      Properties.instance.saveSettings(newSettings);
    });
  }

  _loadUpData() async {
    /// Increase count number to count the how many time user open app
    Properties.instance.saveSettings(Properties.instance.settings
        .copyWith(openAppCount: Properties.instance.settings.openAppCount + 1));
    if (kDebugMode) {
      print(
          " Current Properties.instance.settings.openAppCount value: ${Properties.instance.settings.openAppCount.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    WindowManager.instance.addListener(this);
    // Other loading steps
    _loadUpData();
    if (kDebugMode) {
      print("Data is loaded");
    }
  }

  @override
  void dispose() {
    _saveWindowsSizeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return const HomeView();
      },
      tablet: (context) {
        return Scaffold(
          body: Row(
            children: [
              // Fixed navigation rail on the left (start)
              NavigationRail(
                extended: _isTabletExpanded,
                leading: Padding(
                  padding: EdgeInsets.only(right: _isTabletExpanded ? 178 : 0),
                  child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          _isTabletExpanded = !_isTabletExpanded;
                        });
                      }),
                ),
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: _goBranch,
                labelType: _isTabletExpanded
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.selected,
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
                trailing: buildTabletTrailingButtons(context),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // Main content on the right (end)
              Expanded(
                child: widget.navigationShell,
              ),
            ],
          ),
        );
      },
      desktop: (context) {
        return Scaffold(
          body: Row(
            children: [
              // Fixed navigation rail on the left (start)
              NavigationRail(
                extended: _isDesktopExpanded,
                leading: Padding(
                  padding: EdgeInsets.only(right: _isDesktopExpanded ? 178 : 0),
                  child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          _isDesktopExpanded = !_isDesktopExpanded;
                        });
                      }),
                ),
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: _goBranch,
                labelType: _isDesktopExpanded
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.selected,
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
                trailing: buildDesktopTrailingButtons(context),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // Main content on the right (end)
              Expanded(
                child: widget.navigationShell,
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded buildTabletTrailingButtons(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: _isTabletExpanded ? 258 : 50,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: _isTabletExpanded ? 20 : 4),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            context.pushNamed(RouterConstants.infos);
                          }),
                      if (_isTabletExpanded) ...[
                        const HorizontalSpacing.large(),
                        Text(
                          'About'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ],
                    ],
                  ),
                ),
                SizedBox(
                    width: _isTabletExpanded ? 238 : 50,
                    child: const WaveDivider(
                      thickness: .3,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: _isTabletExpanded ? 20 : 4),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            context.pushNamed(RouterConstants.commonSettings);
                          }),
                      if (_isTabletExpanded) ...[
                        const HorizontalSpacing.large(),
                        Text(
                          'Settings'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildDesktopTrailingButtons(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: _isDesktopExpanded ? 258 : 50,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: _isDesktopExpanded ? 20 : 4),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            context.pushNamed(RouterConstants.infos);
                          }),
                      if (_isDesktopExpanded) ...[
                        const HorizontalSpacing.large(),
                        Text(
                          'About'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ],
                    ],
                  ),
                ),
                SizedBox(
                    width: _isDesktopExpanded ? 238 : 50,
                    child: const WaveDivider(
                      thickness: .3,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: _isDesktopExpanded ? 20 : 4),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            context.pushNamed(RouterConstants.commonSettings);
                          }),
                      if (_isDesktopExpanded) ...[
                        const HorizontalSpacing.large(),
                        Text(
                          'Settings'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
