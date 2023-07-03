import 'package:flutter/material.dart';
import 'package:note_app/screens/speech.dart';

import '../models/note.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _tittlecontroller = TextEditingController();
  TextEditingController _contentcontroller = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _tittlecontroller = TextEditingController(text: widget.note!.titulo);
      _contentcontroller =
          TextEditingController(text: widget.note!.getresumen());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                    ))
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                TextField(
                  controller: _tittlecontroller,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
                ),
                TextField(
                  maxLines: null,
                  controller: _contentcontroller,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'type something here',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                )
              ],
            ))
          ],
        ),
      ),
      
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: FloatingActionButton(
              heroTag: 'boton_ocr',
              elevation: 10,
              
                
              onPressed: () {Navigator.pushNamed(context,"/ocr");},
              
              backgroundColor: Colors.grey.shade800,
              child: Icon(Icons.camera_alt),
          
            ),
          ),
        
        FloatingActionButton(
          heroTag: 'boton_speech',
          
            elevation: 10,
            onPressed: () {Navigator.pushNamed(context,"/speech");},
            
            backgroundColor: Colors.grey.shade800,
            child: Icon(Icons.mic),

          ),

          FloatingActionButton(
            heroTag: 'boton_guardar',
            elevation: 10,
            onPressed: () {
              Navigator.pop(
                  context, [_tittlecontroller.text, _contentcontroller.text]);
            },
            
            backgroundColor: Colors.grey.shade800,
            child: Icon(Icons.save),

          ),
        ],
      ),
      
      
    );
  }
}
