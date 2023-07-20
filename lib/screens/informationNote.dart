import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/repository/note_repository_remote.dart';
import '../constants/status.dart';
import '../models/note.dart';
import 'edit.dart';
import 'geolocator.dart';

class InformationScreen extends StatelessWidget{

  final Note? nota;
  InformationScreen({superKey, this.nota});

  @override
  Widget build(BuildContext context){  
    
    final TextStyle estiloTexto = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final DateFormat formatoFecha = DateFormat('d/M/yyyy, h:mma');

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
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
                  )
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Fecha de creación',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    nota != null ? formatoFecha.format(nota!.fechaCreacion) : 'Fecha Creacion',
                    style: estiloTexto,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fecha de actualización',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    nota != null ? formatoFecha.format(nota!.fechaActualizacion) : 'Fecha Actualizacion',
                    style: estiloTexto,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Latitud',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    nota?.latitud?.toString() ?? 'No hay latitud',
                    style: estiloTexto,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Longitud',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    nota?.altitud?.toString() ?? 'No hay longitud',
                    style: estiloTexto,
                  ),
                  SizedBox(height: 20),
                  FloatingActionButton(
                    
                    onPressed: () async {
                      final comprobarConexion = await NoteRepositoryRemote().comprobarConexion();

                      if(nota!.altitud != null && nota!.latitud != null && comprobarConexion != Status.internetError){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LocationMapView(nota: nota)),
                      );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text('El mapa no puede ser mostrado'),
                            duration: Duration(seconds: 3),
                            ),
                        );
                      }
                      
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.maps_ugc, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}