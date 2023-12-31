import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/edit.dart';
import 'package:note_app/services/note_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  TextEditingController barra = new TextEditingController();
  bool sorted = false;
  bool flag = true;
  NoteService noteService = NoteService();

  DateTime tramsformarfecha(String fecha) {
    DateFormat formato = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime fechaTrans = formato.parse(fecha);
    return fechaTrans;
  }

  Future<void> getdata() async {
    //if (barra.text.isEmpty) {
    //  final url = 'http://192.168.1.97:3000/nota/user/user1';
    //  final response = await http.get(Uri.parse(url));
    //  List<Note> notas = [];
    //  if (response.statusCode == 200) {
    //    List<dynamic> jsonList = jsonDecode(response.body)['value'];
    //    notas = jsonList.map((notaMap) {
    //      return Note.fromMap(notaMap);
    //    }).toList();
    //  }
    //  filteredNotes = notas;
    //} else {
    //  final url = 'http://192.168.1.97:3000/nota/user/user1';
    //  final response = await http.get(Uri.parse(url));
    //  List<Note> notas = [];
    //  if (response.statusCode == 200) {
    //    List<dynamic> jsonList = jsonDecode(response.body)['value'];
    //    notas = jsonList.map((notaMap) {
    //      return Note.fromMap(notaMap);
    //    }).toList();
    //  }
    //  filteredNotes = notas;
    //  List<Note> aux = [];
    //  filteredNotes.forEach((element) {
    //    if (element.titulo.toLowerCase().contains(barra.text.toLowerCase()) ||
    //        element
    //            .getresumen()
    //            .toLowerCase()
    //            .contains(barra.text.toLowerCase())) {
    //      aux.add(element);
    //    }
    //  });
    //  filteredNotes = aux;
    //}
    filteredNotes = await noteService.obtenerTodas();

    if (barra.text.isNotEmpty) {
      List<Note> aux = [];
      filteredNotes.forEach((element) {
        if (element.titulo.toLowerCase().contains(barra.text.toLowerCase()) ||
            element
                .getresumen()
                .toLowerCase()
                .contains(barra.text.toLowerCase())) {
          aux.add(element);
        }
      });
      filteredNotes = aux;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  Future<void> deleteNote(Note nota) async {
    //final url = 'http://192.168.1.97:3000/nota';
    //final headers = {'Content-Type': 'application/json'};
    //final body = jsonEncode({
    //  'id': nota.notaId,
    //  'fechaEliminacion': DateTime.now().toString(),
    //  'usuarioId': nota.usuarioId
    //});
    //
    //final response =
    //    await http.delete(Uri.parse(url), headers: headers, body: body);
    //
    //if (response.statusCode == 200) {
    //  print('La nota fue eliminada');
    //} else {
    //  print('Error al eliminar la nota: ${response.statusCode}');
    //}
    await noteService.eliminar(nota);

    setState(() {
      filteredNotes.remove(nota);
    });

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
                const Text('Notes',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: barra,
              onChanged: (value) {
                getdata();
                setState(() {});
              },
              style: TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: 'Search notas...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent))),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getdata(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error al obtener los datos'),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 30),
                        itemCount: filteredNotes.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(index.toString()),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.delete,
                                        color: Colors.black))),
                            onDismissed: (direction) async {
                              await deleteNote(filteredNotes[index]);
                            },
                            child: Card(
                              margin: EdgeInsets.only(bottom: 20),
                              color: getRandomColor(),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EditScreen(
                                                note: filteredNotes[index]),
                                      ),
                                    );
                                  },
                                  title: RichText(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text:
                                            '${filteredNotes[index].titulo}\n',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            height: 1.5),
                                        children: [
                                          TextSpan(
                                            text: filteredNotes[index]
                                                .getresumen(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                height: 1.5),
                                          )
                                        ]),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].fechaCreacion)}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditScreen(),
            ),
          );
          // if (result[0] != null) {
          //   print(result[0]);
          // }
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  Future<dynamic> confirmationDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: Text(
              'Are tou sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: SizedBox(
                      width: 60,
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: SizedBox(
                      width: 60,
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]),
          );
        });
  }
}
