import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

class Notify {
  static void showAlertDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required VoidCallback action}) {
    showDialog(
      context: context,
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                action();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialogWithoutAction({
      required BuildContext context, required String title, required String content}) {
    showDialog(
      context: context,
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

  static void showLoadingAlertDialog({
      required BuildContext context, required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox().mediumHeight(),
              Text(content),
            ],
          ),
        );
      },
    );
  }

  static void showSnackBar({required BuildContext context, required String content}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            content,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      );
}
