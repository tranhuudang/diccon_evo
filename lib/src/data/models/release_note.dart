class ReleaseNote {
  final String version;
  final String date;
  final List<String> changesNote;

  ReleaseNote({
    required this.version,
    required this.date,
    required this.changesNote,
  });

  factory ReleaseNote.fromJson(Map<String, dynamic> json) {
    return ReleaseNote(
      version: json['version'],
      date: json['date'],
      changesNote: List<String>.from(json['changesNote']),
    );
  }
}