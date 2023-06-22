import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/domain/models/note.dart';
import 'package:path/path.dart';


class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT)");
      },
      version: 1,
    );
  }

  static Future<void> insert(Note note) async {
    Database database = await _openDB();
     database.insert("notes",note.toMap());
  }

  static Future<List<Note>> getAllNotes() async {
    final Database database = await _openDB();
    final List<Map<String, dynamic>> notesMap = await database.query('notes');
    return List.generate(
      notesMap.length,
      (i) => Note(
        id: notesMap[i]['id'],
        title: notesMap[i]['title'],
        body: notesMap[i]['body'],
      ),
    );
  }
}