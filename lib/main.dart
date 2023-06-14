import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/adr_notes/listNotes.dart';
import 'package:flutter_application_1/infrastructure/ui/adr_notes/saveNotes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Material App',
       home: SaveNotes(),
    );
  }
}