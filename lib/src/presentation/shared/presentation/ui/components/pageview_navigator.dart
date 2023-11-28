import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class PageViewNavigator extends StatefulWidget {
  const PageViewNavigator({
    super.key,
    this.height = 500,
    required this.controller,
    required this.itemCount, this.backgroundColor,
  });

  final double? height;
  final PageController controller;
  final int itemCount;
  final Color? backgroundColor;

  @override
  State<PageViewNavigator> createState() => _PageViewNavigatorState();
}

class _PageViewNavigatorState extends State<PageViewNavigator> {
  StreamController currentPageStreamController = StreamController();
  @override
  Widget build(BuildContext context) {
    final Color defaultBackgroundColor = context.theme.highlightColor;
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            initialData: 1,
            stream: currentPageStreamController.stream,
            builder: (context, currentPage) {
              return Row(
                children: [
                  if (currentPage.data > 1)
                    RectangleButton.leftSided(
                      backgroundColor: widget.backgroundColor ?? defaultBackgroundColor,
                      iconData: Icons.chevron_left,
                      onTap: () {
                        widget.controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        currentPageStreamController.add(currentPage.data - 1);
                      },
                    ),
                  const Spacer(),
                  if (currentPage.data < widget.itemCount)
                    RectangleButton.rightSided(
                      backgroundColor: widget.backgroundColor ?? defaultBackgroundColor,
                      iconData: Icons.chevron_right,
                      onTap: () {
                        widget.controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        currentPageStreamController.add(currentPage.data + 1);
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
