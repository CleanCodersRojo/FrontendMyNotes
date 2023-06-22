import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/notes/note_editor.dart';
import 'package:flutter_application_1/infrastructure/ui/notes/listNotes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqflite_common/sqlite_api.dart';

import 'domain/models/note.dart';
void main() async {
  sqflite.databaseFactory = sqflite.databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final note = Note(title: '', body: '');
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: listNotes(), // Agregar el parámetro key
    );
  }
}