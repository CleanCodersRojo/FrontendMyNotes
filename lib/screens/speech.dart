import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:note_app/constants/colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../models/note.dart';
import 'edit.dart';

class SpeechScreen extends StatefulWidget {
  final Dtoforspeechandocr? notasininstanciar;
  final Note? nota;

  const SpeechScreen({super.key, this.notasininstanciar, this.nota});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();

  var text = "Mantén pulsado el botón y empieza a hablar.";
  String text2 = '';
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: Colors.grey.shade900,
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(onResult: (result) {
                    setState(() {
                      text = result.recognizedWords;
                      text2 = text;
                    });
                  });
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade900,
            radius: 35,
            child: Icon(isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (widget.nota != null) {
              List<Cuerpo> cuerponota = [];
              String data = widget.nota!.cuerpo[0].obtenerDato() + ' ' + text2;
              cuerponota.add(CuerpoTexto(tipo: 'Texto Plano', texto: data));
              widget.nota!.cuerpo = cuerponota;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditScreen(note: widget.nota)),
              );
            } else {
              List<Cuerpo> cuerponota = [];
              String data = widget.notasininstanciar!.cuerpo[0].obtenerDato() +
                  ' ' +
                  text2;
              cuerponota.add(CuerpoTexto(tipo: 'Texto Plano', texto: data));
              widget.notasininstanciar!.cuerpo = cuerponota;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditScreen(
                        notasininstanciar: widget.notasininstanciar)),
              );
            }
          },
          icon: Icon(Icons.save),
          splashRadius: 20,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        elevation: 0.0,
        title: const Text(
          'Speech to Text',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: const EdgeInsets.only(bottom: 150),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
