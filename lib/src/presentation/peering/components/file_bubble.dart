import 'package:flutter/material.dart';

class FileBubble extends StatefulWidget {
  final String downloadUrl;
  const FileBubble({
    super.key,
    required this.downloadUrl,
  });

  @override
  State<FileBubble> createState() => _FileBubbleState();
}

class _FileBubbleState extends State<FileBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.86,
                minWidth: MediaQuery.of(context).size.width * 0.30,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius:
                    BorderRadius.circular(8), // Replace BorderRadiusMissing
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement download functionality
                  },
                  child: Text('Download'),
                ),
              )),
        ],
      ),
    );
  }
}
