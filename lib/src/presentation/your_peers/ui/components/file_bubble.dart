import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'dart:io';

class FileBubble extends StatelessWidget {
  final String fileName;
  final String downloadUrl;
  final String senderId;
  final String senderName;

  const FileBubble({
    super.key,
    required this.downloadUrl,
    required this.senderId,
    required this.senderName,
    required this.fileName,
  });

  Future<void> downloadFile(BuildContext context, String url, String fileName) async {
    // Request storage permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Get the device's download directory
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';

        // Check if the file already exists
        if (await File(filePath).exists()) {
          // Show an alert dialog if the file already exists with option to open it
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('File Already Downloaded'),
                content: Text('The file has already been downloaded to:\n$filePath'),
                actions: [
                  TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                      OpenFile.open(filePath);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Show a loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloading $fileName...')),
          );

          // Download the file
          final dio = Dio();
          await dio.download(url, filePath);

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$fileName downloaded successfully!')),
          );
        }
      } catch (e) {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error downloading $fileName: $e')),
        );
      }
    } else {
      // Show a permission denied message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: FirebaseAuth.instance.currentUser!.uid == senderId
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6, top: 2),
          child: Row(
            mainAxisAlignment:
            FirebaseAuth.instance.currentUser!.uid == senderId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.86,
                  minWidth: MediaQuery.of(context).size.width * 0.30,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.download_for_offline_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => downloadFile(context, downloadUrl, fileName),
                    label: Text(
                      fileName,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
