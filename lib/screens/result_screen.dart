import 'package:flutter/material.dart';

import '../models/note.dart';
import 'edit.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  final Dtoforspeechandocr? notasininstanciar;
  final Note? nota;
  const ResultScreen({required this.text, this.nota, this.notasininstanciar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditScreen()),
                      );
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      if (nota != null) {
                        List<Cuerpo> cuerponota = [];
                        String data =
                            nota!.cuerpo[0].obtenerDato() + ' ' + text;
                        cuerponota
                            .add(CuerpoTexto(tipo: 'Texto Plano', texto: data));
                        nota!.cuerpo = cuerponota;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditScreen(note: nota)),
                        );
                      } else {
                        List<Cuerpo> cuerponota = [];
                        String data =
                            notasininstanciar!.cuerpo[0].obtenerDato() +
                                ' ' +
                                text;
                        cuerponota
                            .add(CuerpoTexto(tipo: 'Texto Plano', texto: data));
                        notasininstanciar!.cuerpo = cuerponota;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditScreen(
                                  notasininstanciar: notasininstanciar)),
                        );
                      }
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 30,
                      ),
                    )),
              ]),
              Container(
                child: Text(text, style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ));
  }
}
