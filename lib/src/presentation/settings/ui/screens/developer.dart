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
  bool _isLoading = false;

  Future<void> _countDocuments() async {
    // Todo: fix this function, currently it not able to get the number of document in FirebaseStore
    setState(() {
      _isLoading = true;
    });

    try {
      AggregateQuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Dictionary_V2').count().get();
      setState(() {
        _documentCount = querySnapshot.count ?? 1;
        DebugLog.info("Dictionary_V2: $_documentCount");
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error getting documents: $e");
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
                const Text('We have 4 type:\n'
                    ' -1 is primary key.\n'
                    ' -2 is local backup key.\n'
                    ' -3 is primary cloud key.\n'
                    ' -4 is cloud backup key.')
              ]),
          Section(title: 'Document', children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Number of documents: $_documentCount',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _countDocuments,
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
