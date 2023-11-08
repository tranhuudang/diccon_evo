import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenTextScaleFactor => MediaQuery.textScaleFactorOf(this);
  bool get isSmallScreen => screenSize.width < 800;
  bool get isMediumScreen => screenSize.width >= 800 && screenSize.width < 1300;
  bool get isLargeScreen => screenSize.width >= 1300;
  void showAlertDialog(
      {required String title,
      required String content,
      required VoidCallback action}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                action();
                Navigator.of(context).pop();
              },
              child: Text('OK'.i18n),
            ),
            TextButton(
              onPressed: () {
                // Close the alert dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.i18n),
            ),
          ],
        );
      },
    );
  }

  void showAlertDialogWithoutAction(
      {required String title, required String content}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                // Close the alert dialog
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLoadingAlertDialog(
      {required String title, required String content}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const VerticalSpacing.medium(),
              Text(content),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar({required String content}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: theme.colorScheme.inverseSurface,
          content: Text(
            content,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onInverseSurface),
          ),
        ),
      );
}
