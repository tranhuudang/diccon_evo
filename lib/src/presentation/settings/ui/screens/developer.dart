import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/encrypt_api.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/services.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  final TextEditingController _encodeTextController = TextEditingController();
  final TextEditingController _decodeTextController = TextEditingController();
  String _encodedContent = '';
  String _decodedContent = '';
  int _workingKeyNunber = 0;
  int _documentCount = 0;

  Future<void> _countDocumentsDictionary() async {
    try {
      AggregateQuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseConstant.firestore.dictionary)
          .count()
          .get();
      setState(() {
        _documentCount = querySnapshot.count ?? 1;
        DebugLog.info("Dictionary: $_documentCount");
      });
    } catch (e) {
      DebugLog.info("Error getting documents: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Section(title: 'Create or decode key', children: [
            TextField(
              controller: _encodeTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter content to encode',
              ),
            ),
            16.height,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _encodedContent = EncryptApi.encode(
                    contentToEncode: _encodeTextController.text,
                  );
                });
              },
              child: const Text('Encode'),
            ),
            16.height,
            if (_encodedContent.isNotEmpty) ...[
              SelectableText(
                _encodedContent,
                style: context.theme.textTheme.bodyMedium,
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _encodedContent));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
              ),
            ],
            /////////////////////////////////////
            TextField(
              controller: _decodeTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter content to decode',
              ),
            ),
            16.height,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _decodedContent = EncryptApi.decode(
                    encodedContent: _decodeTextController.text,
                  );
                });
              },
              child: const Text('Decode'),
            ),
            16.height,
            if (_decodedContent.isNotEmpty) ...[
              SelectableText(
                _decodedContent,
                style: context.theme.textTheme.bodyMedium,
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _decodedContent));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
              ),
            ]
          ]),
          8.height,
          Section(
              title: 'Validate OpenAI API keys',
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Check what key is working'),
                    FilledButton(
                        onPressed: () async {
                          _workingKeyNunber = await OpenAIKeySelector.init();
                          setState(() {
                            _workingKeyNunber;
                          });
                        },
                        child: const Text('Check')),
                  ],
                ),
                Text('Current working Open AI API key is: $_workingKeyNunber'),
                const Text('We have 2 type:\n'
                    ' -1 is local key.\n'
                    ' -2 is cloud key.')
              ]),
          Section(title: 'Document', children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dictionary: $_documentCount',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _countDocumentsDictionary,
                  child: const Text('Check Document Count'),
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
