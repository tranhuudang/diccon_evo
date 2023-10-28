import 'dart:ui';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
import 'package:flutter/material.dart';
import 'circle_button.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.actions,
    this.title,
    this.childOfStack = true,
  });

  final List<Widget>? actions;
  final String? title;
  final bool? childOfStack;

  @override
  Widget build(BuildContext context) {
    return childOfStack!
        ? Column(
            children: [
              HeaderWithBlurEffect(title: title, actions: actions),
              const Spacer(),
            ],
          )
        : HeaderWithBlurEffect(title: title, actions: actions);
  }
}

class HeaderWithBlurEffect extends StatelessWidget {
  const HeaderWithBlurEffect({
    super.key,
    required this.title,
    required this.actions,
  });

  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // Blur layers
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ),
            child: Container(),
          ),
          // Gradient layers
          Container(
            height: 66,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  context.theme
                      .colorScheme.background
                      .withOpacity(0.9),
                  context.theme
                      .colorScheme.background
                      .withOpacity(0.5),
                ])),
          ),
          // Child layers
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleButton(
                  backgroundColor: context.theme.colorScheme.surfaceVariant.withOpacity(.5),
                    iconData: Icons.arrow_back,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                const SizedBox().largeWidth(),
                if(title != null)
                    Text(
                        title!,
                        style: context.theme.textTheme.headlineSmall,
                      ),
                const SizedBox(
                  width: 16,
                ),
                const Spacer(),
                if(actions != null)
                     Row(
                        children: actions!,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
