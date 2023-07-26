import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../global.dart';
import '../../helpers/platform_check.dart';

class WindowTileBar extends StatelessWidget  implements PreferredSizeWidget{
  const WindowTileBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return

      PlatformCheck.isMobile()
          ? SizedBox(
        height: 0,
      )
          : PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // Windows 11 title bar color
            border: Border(
              bottom: BorderSide(color: Colors.black12, width: 0.7),
            ),
          ),
          child: MoveWindow(
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  'assets/dictionary/icon.ico',
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Diccon Evo",
                  style: TextStyle(color: Colors.black),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      MinimizeWindowButton(
                        colors: Global.buttonColors,
                      ),
                      MaximizeWindowButton(
                        colors: Global.buttonColors,
                      ),
                      CloseWindowButton(
                        colors: Global.closeButtonColors,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
