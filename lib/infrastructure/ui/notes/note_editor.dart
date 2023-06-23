import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/local/local_note_data_source.dart';
import '../../../domain/models/note.dart';
import '../styles/color.dart';

class NoteEditor extends StatefulWidget {
  Note note;
  NoteEditor(this.note, {Key? key}) : super(key: key);
  
  @override
  _NoteEditorState createState() => _NoteEditorState();
}


class _NoteEditorState extends State<NoteEditor> {
  final _formKey = GlobalKey<FormState>();
  String titulo = '';
  String cuerpo = '';

  @override
  void initState() {
    super.initState();
    titulo = widget.note.getTitle();
    cuerpo = widget.note.getBody();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: colorGrey,

      //Begin AppBar
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
        backgroundColor: colorGrey,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset('lib/assets/icons/bell.png',
            width: 24,
            height: 24,
          ),
          splashRadius: 5,
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('lib/assets/icons/tag.png',
            width: 24,
            height: 24,
          ),
          splashRadius: 5,
          ),
        ],
      ),

      //Begin Body
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children:  <Widget>[
                TextFormField(
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  scrollPadding: const EdgeInsets.all(15),
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "TÍTULO",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorGrey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorGrey)),
                  ),
                  initialValue: titulo,
                  onChanged: (value){
                    setState((){
                      titulo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El título no puede estar vacío';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  scrollPadding: const EdgeInsets.all(15),
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Empieza a escribir",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorGrey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorGrey)),
                  ),
                  initialValue: cuerpo,
                  onChanged: (value){
                    setState((){
                      cuerpo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El cuerpo no puede estar vacío';
                    }
                    return null;
                  },
                  
                ),

                ElevatedButton(
                   onPressed: () {
                     if (_formKey.currentState!.validate()) {
                      
                    
                      // Aquí se guardar los valores en algún lugar
                      // como una base de datos o un archivo
                      
                      print('Título: $titulo');
                      print('Cuerpo: $cuerpo');
                      print('Nota guardada');
                      
                        
                      
                      // Operation.insert(Note(
                      //   title: titulo,
                      //   body: cuerpo,
                      // ));   
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
      

      //Begin BottomNavigationBar
      
bottomNavigationBar: BottomNavigationBar(
    backgroundColor: colorWhite,
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
     BottomNavigationBarItem(
  icon: Row(
    children: [
      Padding(
        padding: EdgeInsets.only(left:90,top: 17),
        child:  Image.asset('lib/assets/icons/franjas_menu.png',
          width: 24,
          height: 24,
        ),
      ),
    ],
  ),
  label: '',
),
      const BottomNavigationBarItem(
        icon: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left:90,top: 17),
               child: Icon(
                 Icons.settings,
                 color: colorBackgroundBlue,
              ),
            ),
          ],
        ),
        label: '',
      ),
    ],
  ),

);

}

}