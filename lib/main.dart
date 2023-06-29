import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/view/note_editor.dart';
import 'package:flutter_application_1/infrastructure/ui/view/listNotes.dart';

import 'infrastructure/ui/view/speech.dart';


void main() async {
  //sqflite.databaseFactory = sqflite.databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home: MiApp(), // Agregar el parámetro key
    );
  }
}

class MiApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => Listado(),
        "/editar": (context) => NoteEditor(),
        "/speech": (context) => SpeechScreen()
      }
    );
  }
}