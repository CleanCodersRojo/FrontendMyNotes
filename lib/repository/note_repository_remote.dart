import '../constants/status.dart';
import '../models/note.dart';
import 'note_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoteRepositoryRemote extends NoteRepository {
  final url = 'http://192.168.1.97:3000';

  @override
  Future<List<Note>> obtenerTodas() async {
    try {
      final response = await http.get(Uri.parse('$url/nota/user/user1'));
      List<Note> notas = [];
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        List<dynamic> jsonList = jsonDecode(response.body)['value'];
        notas = jsonList.map((notaMap) {
          return Note.fromMap(notaMap);
        }).toList();
      }
      return notas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<Status> eliminar(Note nota) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'id': nota.notaId,
        'fechaEliminacion': DateTime.now().toString(),
        'usuarioId': nota.usuarioId
      });
      final response = await http.delete(Uri.parse('$url/nota'),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        print('La nota fue eliminada');
        return Status.ok;
      } else {
        print('Error al eliminar la nota: ${response.statusCode}');
        return Status.requestError;
      }
    } catch (e) {
      print(e);
      return Status.internetError;
    }
  }

  @override
  Future<Status> crear(CreateNotaDto nota) async {
    try {
      List<Map<String, dynamic>> cuerposMap =
          nota.cuerpo.map((c) => c.toMap()).toList();
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'titulo': nota.titulo,
        'cuerpo': cuerposMap,
        'fechaCreacion': DateTime.now().toString(),
        'fechaActualizacion': DateTime.now().toString(),
        'latitud': nota.latitud.hasValue() ? nota.latitud.getValue() : null,
        'altitud': nota.altitud.hasValue() ? nota.altitud.getValue() : null,
        'usuarioId': nota.usuarioId,
      });
      final response =
          await http.post(Uri.parse('$url/nota'), headers: headers, body: body);
      if (response.statusCode == 201) {
        print('La nota fue creada');
        return Status.ok;
      } else {
        print('Error al crear la nota: ${response.statusCode}');
        return Status.requestError;
      }
    } catch (e) {
      print(e);
      return Status.internetError;
    }
  }

  @override
  Future<Status> modificar(Note nota) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      List<Map<String, dynamic>> cuerposMap =
          nota.cuerpo.map((c) => c.toMap()).toList();
      final body = jsonEncode({
        'id': nota.notaId,
        'fechaActualizacion': DateTime.now().toString(),
        'titulo': nota.titulo,
        'cuerpo': cuerposMap,
        'usuarioId': nota.usuarioId,
      });
      print(body);
      final response = await http.patch(Uri.parse('$url/nota'),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        print('La nota fue modificada');
        return Status.ok;
      } else {
        print('Error al modificar la nota: ${response.statusCode}');
        return Status.requestError;
      }
    } catch (e) {
      print(e);
      return Status.internetError;
    }
  }

  Future<Status> comprobarConexion() async {
    try {
      final response = await http.get(Uri.parse('$url/nota/user/user1'));
      if (response.statusCode == 200) {
        return Status.ok;
      } else {
        return Status.requestError;
      }
    } catch (e) {
      print(e);
      return Status.internetError;
    }
  }
}
