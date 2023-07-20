import 'package:note_app/main.dart';
import 'package:note_app/repository/note_repository_local.dart';
import 'package:note_app/repository/note_repository_remote.dart';
import '../constants/status.dart';
import '../models/note.dart';

class NoteService {
  NoteRepositoryRemote remote;
  NoteRepositoryLocal local;

  NoteService()
      : remote = NoteRepositoryRemote(),
        local = NoteRepositoryLocal(storage);

  Future<List<Note>> obtenerTodas() async {
    await syncOut();
    final notas = await remote.obtenerTodas();
    if (notas.isEmpty) {
      return await local.obtenerTodas();
    }
    await syncIn(notas);
    return notas;
  }

  Future<Status> eliminar(Note nota) async {
    final remoteResult = await remote.eliminar(nota);

    if (remoteResult != Status.ok) {
      // eliminar localmente
      return await local.eliminar(nota);
    }

    return remoteResult;
  }

  Future<Status> crear(CreateNotaDto nota) async {
    final remoteResult = await remote.crear(nota);

    if (remoteResult != Status.ok) {
      // crear localmente
      return await local.crear(nota);
    }

    return remoteResult;
  }

  Future<Status> modificar(Note nota) async {
    final remoteResult = await remote.modificar(nota);

    if (remoteResult != Status.ok) {
      // modificar localmente
      return await local.modificar(nota);
    }

    return remoteResult;
  }

  Future<void> syncIn(List<Note> notas) async {
    // Dump database
    await local.eliminarTodo();
    for (var nota in notas) {
      await local.insertarNota(nota);
    }
  }

  Future<void> syncOut() async {
    print('Sincronizando hacia el servidor');
    final conexionRemote = await remote.comprobarConexion();

    if (conexionRemote == Status.internetError) {
      print('No hay conexion a internet');
      return;
    }

    final notasACrear = await local.obtenerNotasACrear();

    for (var nota in notasACrear) {
      // Pasar de Nota a DTO
      CreateNotaDto dto = CreateNotaDto(
          nota.titulo, nota.cuerpo, 
          Optional<double>(nota.latitud), 
          Optional<double>(nota.altitud),
          usuarioId: nota.usuarioId);
      await remote.crear(dto);
    }

    final notasAModificar = await local.obtenerNotasAModificar();

    for (var nota in notasAModificar) {
      await remote.modificar(nota);
    }

    final notasAEliminar = await local.obtenerNotasAEliminar();

    for (var nota in notasAEliminar) {
      await remote.eliminar(nota);
    }

    // Dump database
    await local.eliminarTodo();
  }
}
