import 'package:flutter/material.dart';
import 'package:note_app/screens/edit.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/screens/ocr.dart';
import 'package:note_app/screens/speech.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => HomeScreen(),
        "/editar": (context) => EditScreen(),
        "/speech": (context) => SpeechScreen(),
        "/ocr": (context) => ocrScreen()
      }
    );
  }
}
