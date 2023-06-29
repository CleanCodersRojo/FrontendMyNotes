import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/styles/color.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}


class _SpeechScreenState extends State<SpeechScreen>{
  SpeechToText speechToText = SpeechToText();



  var text = "Mantén pulsado el botón y empieza a hablar.";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: Colors.blue,
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async{
            if(!isListening){
               var available = await speechToText.initialize();
               if(available){
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result){
                      setState(() {
                        text = result.recognizedWords;
                      });
                    }
                  );
                });
               }
            }
          },
          onTapUp: (details){
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
        
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 35,
          child: Icon(isListening ? Icons.mic: Icons.mic_none, color: colorWhite),
        ),
      ),
      ),


      appBar: AppBar(
        leading: IconButton(
                  onPressed: () {
                   Navigator.pop(context);
                  },
                  icon: Image.asset('lib/assets/icons/headline.png',
                    width: 24,
                    height: 24,
                  ),
                  splashRadius: 20,
                ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation:0.0,
        title: const Text(
          'Speech to Text', 
        style: TextStyle(
          fontWeight: FontWeight.w600,
        color: colorWhite),),
      ),



      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: isListening ? Colors.black87 : Colors.black54, fontWeight: FontWeight.w600),
          )
        ),
      ),
    );
  }

}