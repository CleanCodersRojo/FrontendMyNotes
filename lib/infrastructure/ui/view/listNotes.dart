// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/infrastructure/ui/view/note_editor.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:flutter_application_1/domain/models/notes/note.dart';
// import '../../../domain/models/notes/node_id.dart';
// import '../../../domain/models/notes/note_body.dart';
// import '../../../domain/models/notes/note_title.dart';

// class listNotes extends StatelessWidget {
//   const listNotes({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {


//     //final note = Note(title: '', body: '');
//     String title = "MyNotes";
    
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             icon: const Icon(Icons.menu),
//             onPressed: () {},
//           ),
//           title: Text(
//             title,
//           ),
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 255, 255, 255),
//                 Color.fromARGB(255, 58, 176, 255),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             children: [
//               Container(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   margin: const EdgeInsets.fromLTRB(10, 20, 30, 40),
//                   child: Wrap(
//                     spacing: 8.0,
//                     runSpacing: 10.0,
//                     children: [
//                       ActionChip(
//                         onPressed: () {},
//                         label: const Text("Universidad"),
//                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         backgroundColor: Color.fromARGB(255, 248, 116, 116),
//                       ),
//                       ActionChip(
//                         onPressed: () {},
//                         label: const Text("Trabajo"),
//                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         backgroundColor: Color.fromARGB(255, 248, 116, 116),
//                       ),
//                       ActionChip(
//                         onPressed: () {},
//                         label: const Text("Hogar"),
//                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         backgroundColor: Color.fromARGB(255, 248, 116, 116),
//                       ),
//                     ],
//                   )),
//               const Center(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
                    
//                     MaterialPageRoute(builder: (context) => NoteEditor()),
//                   );
//                 },
//                 child: Container(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: _articles.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final item = _articles[index];
//                       return Container(
//                         height: 136,
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8.0),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xFFE0E0E0)),
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8.0)),
//                         padding: const EdgeInsets.all(8),
//                         child: Row(
//                           children: [
//                             Expanded(
//                                 child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.title,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text("${item.author} · ${item.postedOn}",
//                                     style: Theme.of(context).textTheme.caption),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icons.bookmark_border_rounded,
//                                     Icons.share,
//                                     Icons.more_vert
//                                   ].map((e) {
//                                     return InkWell(
//                                       onTap: () {},
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 8.0),
//                                         child: Icon(e, size: 16),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ],
//                             )),
//                             Container(
//                                 width: 100,
//                                 height: 100,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: NetworkImage(item.imageUrl),
//                                     ))),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }

// class Article {
//   final String title;
//   final String imageUrl;
//   final String author;
//   final String postedOn;

//   Article(
//       {required this.title,
//       required this.imageUrl,
//       required this.author,
//       required this.postedOn});
// }

// final List<Article> _articles = [
//   Article(
//     title: "Nota Prueba 1",
//     author:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis orci nec ligula iaculis, sit amet dictum dolor aliquet.",
//     imageUrl: "https://picsum.photos/id/1000/960/540",
//     postedOn: "Yesterday",
//   ),
//   Article(
//       title: "Actividades semanales",
//       imageUrl: "https://picsum.photos/id/1010/960/540",
//       author:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis orci nec ligula iaculis, sit amet dictum dolor aliquet.",
//       postedOn: "4 hours ago"),
//   Article(
//     title: "Lista de tareas",
//     author:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis orci nec ligula iaculis, sit amet dictum dolor aliquet.",
//     imageUrl: "https://picsum.photos/id/1001/960/540",
//     postedOn: "2 days ago",
//   )
// ];





















import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/styles/color.dart';
import '../../../domain/models/notes/note.dart';
import '../../local/local_note_data_source.dart';

class Listado extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  //Color del fondo
    

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3ac3cb), Color(0xFFEf85187)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
    
    
    
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
          //toolbarHeight: 120,


            leading: IconButton(//icono de menú
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              onPressed: () {Navigator.pushNamed(context,"/speech");},
              icon: Image.asset('lib/assets/icons/menu_2.png',
              width: 40,
              height: 40,
              color: colorWhite,
              
            ),
            splashRadius: 25,
        ),
      actions: <Widget>[
         
           IconButton(
              onPressed: () {},
              icon: Image.asset('lib/assets/icons/logo_libro.png',
              width: 40,
              height: 40,
            ),
            splashRadius: 25,
            ),
          
          IconButton(
            onPressed: () {},
            icon: Image.asset('lib/assets/icons/logo_mynotes.png',
            width: 40,
            height: 40,
          ),
          splashRadius: 25,
          ),
        ],
        
        ),
    
        floatingActionButton: FloatingActionButton(//botón de crear nota
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context,"/editar",arguments: Note(id:0,title:"",body:""));
    
          },
        ),


        body: Container(
        

        child: Lista(), 
        ),
      ),
    );
  }
}



class Lista extends StatefulWidget {

  


  @override
  _MiLista createState() => _MiLista();

}

class _MiLista extends State<Lista> {

  List<Note> getNotes = [];

  @override
  void initState() {
    cargaNotes();
    super.initState();
  }

  cargaNotes() async {
    List<Note> auxNote = await DBLocal.getNotes();

    setState(() {
      getNotes = auxNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    

     return   Scaffold(
      backgroundColor: Colors.transparent,
          
          
          
          
          body: ListView.builder(
          itemCount: getNotes.length,
          itemBuilder:
              (context, i) =>
            Dismissible(key: Key(i.toString()),
                direction: DismissDirection.startToEnd,
                background: Container (
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 5),
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.delete, color: Colors.black)
                )
                ),
              onDismissed: (direction) {
                DBLocal.delete(getNotes[i]);
              },
              child: ListTile(
                title: Text(getNotes[i].title),
                trailing: MaterialButton(
                  onPressed: () {
                   Navigator.pushNamed(context,"/editar",arguments: getNotes[i]);
                  }, 
                  child: Icon(Icons.edit)
                )
              )
            )
            
            ),

            


        );
  }

}


























// class Listado extends StatefulWidget {
//   @override
//   _ListadoState createState() => _ListadoState();
// }

// class _ListadoState extends State<Listado> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Note> _notes = [];
//   List<Note> _filteredNotes = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadNotes();
//   }

//   void _loadNotes() async {
//     final notes = await DBLocal.getNotes();
//     setState(() {
//       _notes = notes;
//       _filteredNotes = notes;
//     });
//   }

//   void _filterNotes(String query) {
//     final filteredNotes = _notes.where((note) {
//       final title = note.title.toLowerCase();
//       final body = note.body.toLowerCase();
//       final lowerCaseQuery = query.toLowerCase();
//       return title.contains(lowerCaseQuery) || body.contains(lowerCaseQuery);
//     }).toList();
//     setState(() {
//       _filteredNotes = filteredNotes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Notes'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: _SearchDelegate(_filterNotes));
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: _filterNotes,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredNotes.length,
//               itemBuilder: (context, index) {
//                 final note = _filteredNotes[index];
//                 return ListTile(
//                   title: Text(note.title),
//                   subtitle: Text(note.body),
//                   onTap: () {
//                     Navigator.pushNamed(context, '/editar', arguments: note);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.pushNamed(context, '/editar', arguments: Note(id: 0, title: '', body: ''));
//         },
//       ),
//     );
//   }
// }

// class _SearchDelegate extends SearchDelegate<String> {
//   final Function(String) filterNotes;

//   _SearchDelegate(this.filterNotes);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           filterNotes(query);
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Container();
//   }
// }