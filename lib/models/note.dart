import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class Cuerpo {
  late String tipo;
  Map<String, dynamic> toMap();
}

class CuerpoTexto implements Cuerpo {
  @override
  String tipo;
  String texto;

  CuerpoTexto({required this.tipo, required this.texto});

  factory CuerpoTexto.fromMap(Map<String, dynamic> json) {
    return CuerpoTexto(tipo: json['tipo'], texto: json['texto']);
  }

  Map<String, dynamic> toMap() {
    return {'tipo': 'Texto Plano', 'texto': texto};
  }
}

class CuerpoImagen implements Cuerpo {
  @override
  String tipo;
  num bytes;

  CuerpoImagen({required this.tipo, required this.bytes});

  factory CuerpoImagen.fromMap(Map<String, dynamic> json) {
    return CuerpoImagen(tipo: json['tipo'], bytes: json['bytes']);
  }

  Map<String, dynamic> toMap() {
    return {'tipo': 'Imagen', 'bytes': bytes};
  }
}

class Note {
  String notaId;
  String titulo;
  List<Cuerpo> cuerpo;
  DateTime fechaCreacion;
  DateTime? fechaEliminacion;
  DateTime fechaActualizacion;
  double? latitud;
  double? altitud;
  String usuarioId;

  Note({
    required this.notaId,
    required this.titulo,
    required this.cuerpo,
    required this.fechaCreacion,
    required this.fechaEliminacion,
    required this.fechaActualizacion,
    required this.latitud,
    required this.altitud,
    required this.usuarioId,
  });

  String getresumen() {
    StringBuffer sb = StringBuffer();

    for (Cuerpo c in cuerpo) {
      if (c is CuerpoTexto) {
        sb.write(c.texto);
        sb.write(' ');
      } else if (c is CuerpoImagen) {
        sb.write(c.bytes.toString());
        sb.write(' ');
      }
    }

    return sb.toString();
  }

  factory Note.fromMap(Map<String, dynamic> json) {
    List<dynamic> cuerpoJson = json['cuerpo'];
    List<Cuerpo> cuerpo = [];
    for (var i = 0; i < cuerpoJson.length; i++) {
      var cuerpoMap = cuerpoJson[i];
      var tipo = cuerpoMap['tipo'];
      if (tipo == 'Texto Plano') {
        cuerpo.add(CuerpoTexto.fromMap(cuerpoMap));
      } else if (tipo == 'Imagen') {
        cuerpo.add(CuerpoImagen.fromMap(cuerpoMap));
      } else {
        throw Exception('Tipo de cuerpo no válido: $tipo');
      }
    }

    return Note(
      notaId: json['notaId'],
      titulo: json['titulo'],
      cuerpo: cuerpo,
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      fechaEliminacion: json['fechaEliminacion']['value'] == null
          ? null
          : DateTime.parse(json['fechaEliminacion']['value']),
      fechaActualizacion: DateTime.parse(json['fechaActualizacion']),
      latitud: json['latitud']['value'] == null
          ? null
          : double.parse(json['latitud']['value'].toString()),
      altitud: json['altitud']['value'] == null
          ? null
          : double.parse(json['altitud']['value'].toString()),
      usuarioId: json['usuarioId'],
    );
  }
}

class CreateNotaDto {
  String titulo;
  String cuerpo;
  double latitud;
  double altitud;
  String usuarioId;

  CreateNotaDto(this.titulo, this.cuerpo,
      {this.latitud = 0, this.altitud = 0, this.usuarioId = 'user1'});

  Future<void> crearNota() async {
    final url = Uri.parse('http://192.168.1.97:3000/nota');
    final response = await http.post(
      url,
      body: json.encode({
        'titulo': titulo,
        'cuerpo': cuerpo,
        'fechaCreacion': DateTime.now().toString(),
        'fechaEliminacion': null,
        'fechaActualizacion': DateTime.now().toString(),
        'latitud': latitud,
        'altitud': altitud,
        'usuarioId': usuarioId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Nota creada exitosamente');
    } else {
      print('Error al crear la nota');
    }
  }
}
