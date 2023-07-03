import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget{
  final String text;
  const ResultScreen({required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Resultado"),
    ),
    body: Container(
      padding: const EdgeInsets.all(30.0),
      child: Text(text),
    ),
  );
}