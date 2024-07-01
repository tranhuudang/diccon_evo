import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:window_manager/window_manager.dart';

class DesktopHomeView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const DesktopHomeView({
    super.key,
    required this.navigationShell,
  });

  @override
  State<DesktopHomeView> createState() => _DesktopHomeViewState();
}

class _DesktopHomeViewState extends State<DesktopHomeView> with WindowListener {
  bool _isTabletExpanded = false;
  Timer? _saveWindowsSizeTimer;

  // Using navigationShell to go to different branches using provided index
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: true,
    );
    // Save selected tab to properties
    final newSettings = Properties.instance.settings
        .copyWith(selectedTab: RoutePath.fromIndex(index));
    Properties.instance.saveSettings(newSettings);
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
              // NavigationRailDestination(
              //   icon: const FaIcon(FontAwesomeIcons.comments),
              //   selectedIcon: const FaIcon(FontAwesomeIcons.solidComments),
              //   label: Text('Dialogue'.i18n),
              // ),
              // NavigationRailDestination(
              //   icon: const FaIcon(FontAwesomeIcons.lightbulb),
              //   selectedIcon: const FaIcon(FontAwesomeIcons.solidLightbulb),
              //   label: Text('Chatbot'.i18n),
              // ),
              // NavigationRailDestination(
              //   icon: const Icon(Icons.directions_run_outlined),
              //   selectedIcon: const Icon(Icons.directions_run),
              //   label: Text('Practice'.i18n),
              // ),
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
                  padding: EdgeInsets.only(left: _isTabletExpanded ? 20 : 2),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.account_circle_outlined),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DesktopUserSettingsView()));
                          }),
                      if (_isTabletExpanded) ...[
                        16.width,
                        Text(
                          'Account'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ]
                    ],
                  ),
                ),
                8.height,
                Padding(
                  padding: EdgeInsets.only(left: _isTabletExpanded ? 20 : 2),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsView()));
                          }),
                      if (_isTabletExpanded) ...[
                        16.width,
                        Text(
                          'Settings'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ]
                    ],
                  ),
                ),
                SizedBox(
                    width: _isTabletExpanded ? 238 : 50,
                    child: const WaveDivider(
                      thickness: .3,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: _isTabletExpanded ? 20 : 2),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const InfoView()));
                          }),
                      if (_isTabletExpanded) ...[
                        16.width,
                        Text(
                          'About'.i18n,
                          style: context.theme.textTheme.titleSmall,
                        )
                      ],
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
