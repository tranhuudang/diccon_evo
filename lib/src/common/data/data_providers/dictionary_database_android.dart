import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DictionaryDatabaseAndroid {
  DictionaryDatabaseAndroid._privateConstructor();
  static Future<void> initialize() async {
    if (instance._database == null) {
      await instance._initDB();
    }
  }

  static final DictionaryDatabaseAndroid instance = DictionaryDatabaseAndroid._privateConstructor();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database doesn't exist, copy it from assets
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    if (_database != null) return _database!;
    // Get the path to the database file in the assets folder
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "en_vi.db");

    // Check if the database file already exists in the assets folder
    bool exists = await databaseExists(path);

    if (!exists) {
      // Should happen only once, when the app is first installed
      if (kDebugMode) {
        print("Copying database from assets to $path");
      }
      ByteData data = await rootBundle.load("assets/dictionary/en_vi.db");
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open the database
    return await openDatabase(
      path,
      version: 1,
      singleInstance: true, // Ensure only one instance of the database
    );
  }

  Future<List<Map<String, dynamic>>> queryDictionary(String word) async {
    final db = await instance.database;
    return await db.query('en_vi', where: 'word = ?', whereArgs: [word]);
  }
}
