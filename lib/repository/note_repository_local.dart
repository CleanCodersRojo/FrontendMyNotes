import 'dart:io';
import 'dart:math';

import '../constants/status.dart';
import '../models/note.dart';
import '../storage/local_storage.dart';
import 'note_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoteRepositoryLocal extends NoteRepository { // Capa de Infraestructura 
  final LocalStorage storage;

  NoteRepositoryLocal(this.storage);

  @override
  Future<List<Note>> obtenerTodas() async {
    try {
      final dbResult =
          await storage.query('SELECT * FROM notas WHERE sync_delete <> 1');

      List<Note> notas = [];

      dbResult.forEach((element) {
        notas.add(Note.fromMap(jsonDecode(element['content'] as String)));
      });

      return notas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> insertarNota(Note nota) async {
    try {
      await storage.insert('INSERT INTO notas (id, content) VALUES (?, ?)',
          [nota.notaId, jsonEncode(nota.toMap())]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Status> eliminar(Note nota) async {
    try {
      await storage.update(
          'UPDATE notas SET sync_delete = 1 WHERE id = ?', [nota.notaId]);

      return Status.ok;
    } catch (e) {
      print(e);
      return Status.requestError;
    }
  }

  @override
  Future<Status> crear(CreateNotaDto nota) async {
    try {
      List<Map<String, dynamic>> cuerposMap =
          nota.cuerpo.map((c) => c.toMap()).toList();
      var json = jsonEncode({
        'notaId': randomAlphaNumeric(),
        'titulo': nota.titulo,
        'cuerpo': cuerposMap,
        'latitud': {
          'value': nota.latitud.hasValue() ? nota.latitud.getValue() : null,
          'assign': nota.latitud.hasValue(),
        },
        'altitud': {
          'value': nota.altitud.hasValue() ? nota.altitud.getValue() : null,
          'assign': nota.altitud.hasValue(),
        },
        'usuarioId': nota.usuarioId,
        'fechaCreacion': DateTime.now().toString(),
        'fechaActualizacion': DateTime.now().toString(),
        'fechaEliminacion': {
          'value': null,
          'assign': false,
        }
      });

      var note = Note.fromMap(jsonDecode(json));
      await storage.insert(
          'INSERT INTO notas (id, content, sync_create) VALUES (?, ?, 1)',
          [note.notaId, jsonEncode(note.toMap())]);
      return Status.ok;
    } catch (e) {
      print(e);
      return Status.requestError;
    }
  }

  @override
  Future<Status> modificar(Note nota) async {
    try {
      nota.fechaActualizacion = DateTime.now();
      await storage.update(
          'UPDATE notas SET content = ?, sync_update = 1 WHERE id = ?',
          [jsonEncode(nota.toMap()), nota.notaId]);
      return Status.ok;
    } catch (e) {
      print(e);
      return Status.internetError;
    }
  }

  Future<void> eliminarTodo() async {
    try {
      await storage.delete('DELETE FROM notas');
    } catch (e) {
      print(e);
    }
  }

  Future<List<Note>> obtenerNotasAEliminar() async {
    try {
      final dbResult = await storage
          .query('SELECT content FROM notas WHERE sync_delete = 1');

      List<Note> notas = [];

      dbResult.forEach((element) {
        notas.add(Note.fromMap(jsonDecode(element['content'] as String)));
      });

      return notas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Note>> obtenerNotasACrear() async {
    try {
      final dbResult = await storage.query(
          'SELECT content FROM notas WHERE sync_create = 1 AND sync_delete <> 1');

      List<Note> notas = [];

      dbResult.forEach((element) {
        notas.add(Note.fromMap(jsonDecode(element['content'] as String)));
      });

      return notas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Note>> obtenerNotasAModificar() async {
    try {
      final dbResult = await storage.query(
          'SELECT content FROM notas WHERE sync_update = 1 AND sync_delete <> 1');

      List<Note> notas = [];

      dbResult.forEach((element) {
        notas.add(Note.fromMap(jsonDecode(element['content'] as String)));
      });

      return notas;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

randomAlphaNumeric() {
  return 'nota${Random().nextInt(100000)}';
}
