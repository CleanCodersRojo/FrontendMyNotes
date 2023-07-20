import '../constants/status.dart';
import '../models/note.dart';

abstract class NoteRepository {// Capa de dominio (CRUD) - Repository
  Future<List<Note>> obtenerTodas();
  Future<Status> modificar(Note nota);
  Future<Status> crear(CreateNotaDto nota);
  Future<Status> eliminar(Note nota);
}
