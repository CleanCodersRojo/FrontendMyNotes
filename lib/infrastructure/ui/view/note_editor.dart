import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/notes/node_id.dart';
import 'package:flutter_application_1/infrastructure/local/local_note_data_source.dart';
import '../../../domain/models/notes/note.dart';
import '../styles/color.dart';

class NoteEditor extends StatefulWidget {
  
  NoteEditor({Key? key}) : super(key: key);
  
  @override
  _NoteEditorState createState() => _NoteEditorState();
}


class _NoteEditorState extends State<NoteEditor> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

    
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context)!.settings.arguments as Note;
    titleController.text = note.title;
    bodyController.text = note.body;

    return Scaffold(
      backgroundColor: colorGrey,



      //Begin AppBar
      appBar: AppBar(
        backgroundColor: colorGrey,
        elevation: 0,
        
       
          
          
          
                leading: Row(
                children:[
                IconButton(padding: EdgeInsets.only(left: 15),
                  onPressed: () {
                   Navigator.pop(context);
                  },
                  icon: Image.asset('lib/assets/icons/headline.png',
                    width: 24,
                    height: 24,
                  ),
                  splashRadius: 20,
                ),
            
                
                ],
                ),
                actions:[
                  IconButton(
                   onPressed: () {
                    
                    if (_formKey.currentState!.validate()) {
                      // Aquí se guardar los valores en algún lugar
                      // como una base de datos o un archivo
                            if (note.id! > 0) {
                              note.title = titleController.text;
                              note.body = bodyController.text;
                              DBLocal.update(note);
                              print('Título: $note.title');
                              print('Cuerpo: $note.body');
                              print('Nota guardada');
                            }
                            else
                              DBLocal.insert(Note(title: titleController.text, body: bodyController.text));
                            Navigator.pushNamed(context,"/");
                          }
                        },
                  icon: Image.asset('lib/assets/icons/guardar.png',width: 39,
                    height: 39,),
                  // child: ,
                ),
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
                  controller: titleController,
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
                  // initialValue: titulo,
                  // onChanged: (value){
                  //   setState((){
                  //     titulo = value;
                  //   });
                  // },
              
                  validator: (value) {
                    if (value!.isEmpty) 
                      return 'El título no puede estar vacío';
                    
                    return null;
                  },
                ),
                TextFormField(
                  controller: bodyController,
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
                  // initialValue: cuerpo,
                  // onChanged: (value){
                  //   setState((){
                  //     cuerpo = value;
                  //   });
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El cuerpo no puede estar vacío';
                    }
                    return null;
                  },
                  
                ),
              // ElevatedButton(
              //      onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         // Aquí se guardar los valores en algún lugar
              //         // como una base de datos o un archivo
              //               if (note.id! > 0) {
              //                 note.title = titleController.text;
              //                 note.body = bodyController.text;
              //                 DBLocal.update(note);
              //                 print('Título: $note.title');
              //                 print('Cuerpo: $note.body');
              //                 print('Nota guardada');
              //               }
              //               else
              //                 DBLocal.insert(Note(title: titleController.text, body: bodyController.text));
              //               Navigator.pushNamed(context,"/");
              //             }
              //           },
              //     child: Text('Guardar'),
              //   ),
                
              ],
            ),
          ),
        ),
      ),
      

//Begin BottomNavigationBar
bottomNavigationBar: SizedBox(
  
  
  child:   BottomNavigationBar(
  
      
  
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
    
),

);

}

}



































// import 'package:flutter/material.dart';

// import '../../../domain/models/notes/note.dart';
// import '../../local/local_note_data_source.dart';


// class NoteEditor extends StatelessWidget {

//   final _formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   final bodyController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//     Note note = ModalRoute.of(context)!.settings.arguments as Note;
//     titleController.text = note.title;
//     bodyController.text = note.body;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Guardar")
//       ),
//       body: Container(
//         padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//           child: Form (
//               key: _formKey,
//               child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       controller: titleController,
//                       validator: (value) {
//                         if (value!.isEmpty)
//                           return "El nombre es obligatorio";
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           labelText: "Nombre"
//                       ),

//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: bodyController,
//                       validator: (value) {
//                         if (value!.isEmpty)
//                           return "La especie es obligatoria";
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           labelText: "Especie"
//                       ),
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             if (note.id! > 0) {
//                               note.title = titleController.text;
//                               note.body = bodyController.text;
//                               DBLocal.update(note);
//                             }
//                             else
//                               DBLocal.insert(Note(title: titleController.text, body: bodyController.text));
//                             Navigator.pushNamed(context,"/");
//                           }
//                         },
//                         child: Text("Guardar"))
//                   ]
//               )
//           ),
          
//       )
//     );
//   }

// }
