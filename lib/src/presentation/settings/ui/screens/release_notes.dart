import 'dart:convert';

import 'package:diccon_evo/src/data/data.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReleaseNotes extends StatefulWidget {
  const ReleaseNotes({super.key});

  @override
  State<ReleaseNotes> createState() => _ReleaseNotesState();
}

class _ReleaseNotesState extends State<ReleaseNotes> {
  List<ReleaseNote> releaseNotes = [];
  bool isLoading = true;

  Future<void> loadReleaseNotes() async {
    final String response =
    await rootBundle.loadString(LocalDirectory.releaseNotes);
    final List<dynamic> data = json.decode(response);
    setState(() {
      releaseNotes = data.map((json) => ReleaseNote.fromJson(json)).toList();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadReleaseNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Release notes".i18n,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: releaseNotes.length,
        itemBuilder: (BuildContext context, int index) {
          return ReleaseNotesItem(
              version: releaseNotes[index].version,
              date: releaseNotes[index].date,
              changesNote: releaseNotes[index].changesNote);
        },
      ),
    );
  }
}

class ReleaseNotesItem extends StatelessWidget {
  const ReleaseNotesItem({
    super.key,
    required this.version,
    required this.date,
    required this.changesNote,
  });
  final String version;
  final String date;
  final List<String> changesNote;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            version,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(date),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: changesNote.map((e) => Text('- $e')).toList(),
      ),
    );
  }
}
