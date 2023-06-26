import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/domain/models/notes/note.dart';
import 'package:path/path.dart';


class DBLocal {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT)",
        );
      }, version: 1);
  }
 
  static Future<void> insert(Note note) async {
    Database database = await _openDB();
     database.insert("notes", note.toMap());
  }


  static Future<int> delete(Note note) async {//Eliminar una nota
    Database database = await _openDB();
    return database.delete("notes", where: "id = ?", whereArgs: [note.id]);
  }


  static Future<int> update(Note note) async {
    Database database = await _openDB();
    return database.update("notes", note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }


  static Future<void> insert2(Note note) async {
    Database database = await _openDB();
    var resultado = await database.rawInsert("INSERT INTO notes (title, body)"
     "VALUES (${note.title}, ${note.body})");
  }




  static Future<List<Note>> getNotes() async {//Traer todas las notas
    Database database = await _openDB();
    final List<Map<String, dynamic>> notesMap = await database.query("notes");

    return List.generate(notesMap.length,
            (i) => Note(
              id: notesMap[i]['id'],
              title: notesMap[i]['title'],
              body: notesMap[i]['body']
            ));
  }


 


  // static Future<List<Note>> getAllNotes() async {
  //   final Database database = await _openDB();
  //   final List<Map<String, dynamic>> notesMap = await database.query('notes');
  //   return List.generate(
  //     notesMap.length,
  //     (i) => Note(
  //       id: notesMap[i]['id'],
  //       title: notesMap[i]['title'],
  //       body: notesMap[i]['body'],
  //     ),
  //   );
  // }



  
}