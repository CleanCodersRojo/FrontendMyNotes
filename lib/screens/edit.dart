import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/screens/speech.dart';
import 'package:note_app/services/note_service.dart';
import '../models/note.dart';
import 'informationNote.dart';
import 'ocr.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  final Dtoforspeechandocr? notasininstanciar;
  const EditScreen({super.key, this.note, this.notasininstanciar});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  HtmlEditorController _controller = HtmlEditorController();
  var position;
  TextEditingController _tittlecontroller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final NoteService noteService =  NoteService();
  @override
  void initState() {
    if (widget.note != null) {
      _tittlecontroller = TextEditingController(text: widget.note!.titulo);
    } else if (widget.notasininstanciar != null) {
      _tittlecontroller =
          TextEditingController(text: widget.notasininstanciar!.titulo);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (widget.note != null) {
                            //ServicioModificarnota service =
                            //    new ServicioModificarnota();
                            List<Cuerpo> cuerponota = [];
                            cuerponota.add(CuerpoTexto(
                                tipo: 'Texto Plano',
                                texto: await _controller.getText()));
                            widget.note!.cuerpo = cuerponota;
                            widget.note!.titulo = _tittlecontroller.text;
                            //service.modificar(widget.note!);
                            noteService.modificar(widget.note!);
                          } else {
                            List<Cuerpo> cuerponota = [];
                            cuerponota.add(CuerpoTexto(
                                tipo: 'Texto Plano',
                                texto: await _controller.getText()));
                                
                              try{
                                  position = await Geolocator.getCurrentPosition(//obtener la ubicacion
                                    desiredAccuracy: LocationAccuracy.high,
                                );
                              }catch(e){
                                print(e);
                              }                              
                              CreateNotaDto newnota = CreateNotaDto(
                                _tittlecontroller.text,
                                cuerponota,
                                Optional<double>(position.latitude),
                                Optional<double>(position.longitude));
                              //newnota.crearNota();
                              noteService.crear(newnota);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
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
                            Icons.check,
                            color: Colors.green,
                            size: 30,
                          ),
                        )),
                    IconButton(

                    onPressed: () async {
                      if(widget.note != null){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InformationScreen(nota: widget.note,)),
                      );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text('La información de la nota todavía no se puede visualizar.'),
                            ),
                        );
                      }
                      
                      
                    
                    },
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 30,
                      ),
                    ))
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    focusNode: _focusNode,
                    cursorColor: Colors.white,
                    controller: _tittlecontroller,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Titulo',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  HtmlEditor(
                    callbacks: Callbacks(
                      onFocus: () {
                        if (_focusNode.hasFocus) {
                          _focusNode.unfocus();
                        }
                      },
                      onInit: () {
                        if (widget.note != null) {
                          _controller
                              .setText(widget.note!.cuerpo[0].obtenerDato());
                        } else if (widget.notasininstanciar != null) {
                          _controller.setText(widget
                              .notasininstanciar!.cuerpo[0]
                              .obtenerDato());
                        }
                      },
                    ),
                    controller: _controller,
                    htmlEditorOptions: HtmlEditorOptions(
                      darkMode: true,
                      hint: "Escribe algo...",
                      initialText: "",
                    ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.custom,
                    ),
                    otherOptions: OtherOptions(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.transparent),
                        color: Colors.grey.shade900,
                      ),
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ],
              ),
            ),
            ToolbarWidget(
              controller: _controller,
              htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.custom,
                  toolbarType: ToolbarType.nativeScrollable,
                  toolbarItemHeight: 50,
                  defaultToolbarButtons: [
                    FontButtons(
                        clearAll: false,
                        strikethrough: false,
                        subscript: false,
                        superscript: false),
                    ColorButtons(),
                    ListButtons(listStyles: false),
                    ParagraphButtons(
                        increaseIndent: false,
                        decreaseIndent: false,
                        textDirection: false,
                        lineHeight: false,
                        caseConverter: false),
                    InsertButtons(
                        link: false,
                        picture: true,
                        audio: false,
                        video: false,
                        otherFile: false,
                        table: false,
                        hr: true),
                    OtherButtons(
                        fullscreen: false, codeview: false, help: false),
                    StyleButtons(),
                    FontSettingButtons(),
                  ],
                  customToolbarButtons: [
                    //your widgets here
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade900)),
                      onPressed: () async {
                        if (widget.note != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ocrScreen(
                                      nota: widget.note,
                                    )),
                          );
                        } else {
                          List<Cuerpo> cuerponota = [];
                          cuerponota.add(CuerpoTexto(
                              tipo: 'Texto Plano',
                              texto: await _controller.getText()));
                          Dtoforspeechandocr notanoinstanciada =
                              new Dtoforspeechandocr(
                                  _tittlecontroller.text, cuerponota);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ocrScreen(
                                      notasininstanciar: notanoinstanciada,
                                    )),
                          );
                        }
                      },
                      child: Icon(Icons.camera_alt),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        if (widget.note != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpeechScreen(
                                      nota: widget.note as Note,
                                    )),
                          );
                        } else {
                          List<Cuerpo> cuerponota = [];
                          cuerponota.add(CuerpoTexto(
                              tipo: 'Texto Plano',
                              texto: await _controller.getText()));
                          Dtoforspeechandocr notanoinstanciada =
                              new Dtoforspeechandocr(
                                  _tittlecontroller.text, cuerponota);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpeechScreen(
                                      notasininstanciar: notanoinstanciada
                                          as Dtoforspeechandocr,
                                    )),
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade900)),
                      child: Icon(Icons.mic),
                    )
                  ],
                  buttonColor: Colors.white,
                  dropdownBackgroundColor: Colors.black,
                  textStyle: TextStyle(
                    color: Colors.white,
                  ) //required to place toolbar anywhere!
                  //other options
                  ),
              callbacks: null,
            )
          ],
        ),
      ),
    );
  }
}
