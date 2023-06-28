import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;

  DateTime tramsformarfecha(String fecha) {
    DateFormat formato = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime fechaTrans = formato.parse(fecha);
    return fechaTrans;
  }

  Future<void> getdata() async {
    final url = 'http://192.168.0.106:3000/nota/findbyuserid/user1';
    final response = await http.get(Uri.parse(url));
    List<Note> notasList = [];
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      List<dynamic> notas = responseJson['value'];

      // ignore: avoid_function_literals_in_foreach_calls
      notas.forEach((nota) {
        DateTime fc = tramsformarfecha(nota['fechaCreacion']);
        DateTime fa = tramsformarfecha(nota['fechaActualizacion']);

        notasList.add(Note(
            notaId: nota['notaId'],
            titulo: nota['titulo'],
            cuerpo: nota['cuerpo'],
            fechaCreacion: fc,
            fechaActualizacion: fa,
            latitud: nota['latitud'].toDouble(),
            longitud: nota['altitud'].toDouble(),
            usuarioId: nota['usuarioId']));
      });
      filteredNotes = notasList;
    } else {
      throw Exception('Error al obtener los datos');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes
          .sort((a, b) => a.fechaActualizacion.compareTo(b.fechaActualizacion));
    } else {
      notes
          .sort((b, a) => a.fechaActualizacion.compareTo(b.fechaActualizacion));
    }
    sorted = !sorted;

    return notes;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void deleteNote(int index) async {
    Note note = filteredNotes[index];
    final url = 'http://192.168.0.106:3000/nota/${note.notaId}';
    await http.delete(Uri.parse(url));
    setState(() {
      filteredNotes.remove(note);
    });
  }

  void onSearchTextChanged(String search) {
    setState(() {
      filteredNotes
          .where((note) =>
              note.titulo.toLowerCase().contains(search.toLowerCase()) ||
              note.titulo.toLowerCase().contains(search.toLowerCase()))
          .toList();
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
                      setState(() {
                        filteredNotes = sortNotesByModifiedTime(filteredNotes);
                      });
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: onSearchTextChanged,
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
                          return Card(
                            margin: EdgeInsets.only(bottom: 20),
                            color: getRandomColor(),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditScreen(
                                              note: filteredNotes[index]),
                                    ),
                                  );
                                  /*
                        if (result != null) {
                          setState(() {
                            int original_index =
                                sampleNotes.indexOf(filteredNotes[index]);

                            sampleNotes[original_index] = Note(
                                id: sampleNotes[original_index].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());

                            filteredNotes[index] = Note(
                                id: filteredNotes[index].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());
                          });
                        }
                        */
                                },
                                title: RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text: '${filteredNotes[index].titulo}\n',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          height: 1.5),
                                      children: [
                                        TextSpan(
                                          text: filteredNotes[index].cuerpo,
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
                                trailing: IconButton(
                                  onPressed: () async {
                                    final result =
                                        await confirmationDialog(context);
                                    if (result != null && result) {
                                      deleteNote(index);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
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
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );
          if (result != null) {
            CreateNotaDto nota = CreateNotaDto(result[0], result[1]);
            setState(() {
              nota.crearNota();
            });
          }
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
