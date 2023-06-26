// import 'package:flutter_application_1/domain/models/notes/node_id.dart';
// import 'package:flutter_application_1/domain/models/notes/note_body.dart';
// import 'package:flutter_application_1/domain/models/notes/note_title.dart';

// import '../../DDD/result.dart';

class Note { 
  // NoteId id;
  // NoteTitle title;
  // NoteBody body;

  int ?id;
  String title;
  String body;

// ._constructor
  Note({this.id,required this.title,required this.body});

  Map<String, dynamic> toMap() {
    return { 'id': id, 'title': title, 'body': body};
  }

//   static Result<Note> fromMap(Map<String, dynamic> map) {

//     try{//Se validan cada uno de los ValueObjects
//     final id = NoteId.create(map['id']).fold(
//       (exception) => throw exception,
//       (value) => value,
//     );
//     final title = NoteTitle.create(map['title']).fold(
//       (exception) => throw exception,
//       (value) => value,
//     );
//     final body = NoteBody.create(map['body']).fold(
//       (exception) => throw exception,
//       (value) => value,
//     );

//     return Success(Note._constructor(
//           id: id,
//           title: title,
//           body: body,
//         )
//       );
//     }catch(e){
//       return Error(Exception('Error al crear la nota.'
//             'No se ha podido parsear los datos. $e'));
//     }
//   }

// /// Método de fábrica para crear un [Map<String, dynamic>]
//   /// a partir de un [Note]
//   static Result<Map<String, dynamic>> toMap (Note note) {
//     try {
//       return Success({
//         'id': note.id.value,
//         'title': note.title.value,
//         'body': note.body.value,
//         //'image': note.image.value,
//         //'date': note.date.value,
//         //...
//       });
//     } catch (e) {
//       return Error(Exception('''[Note]: Error al convertir la nota a un mapa. 
//         No se ha podido parsear los datos. $e'''));
//     }
//   }

  // Map<String, dynamic> toMap2() {
  //   return {
  //     'id': id.value,
  //     'title': title.value,
  //     'body': body.value,
  //   };
  // }



// @override
//   String toString() {
//     return 'Note(\n\tid: ${id.toString()}, \n\ttitle: ${title.toString()}, \n\tbody: ${body.toString()})';
//   }

}