import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse, parseFragment;

abstract class Cuerpo {
  late String tipo;
  Map<String, dynamic> toMap();

  T obtenerDato<T>();
}

class Dtoforspeechandocr {
  String titulo;
  List<Cuerpo> cuerpo;
  Dtoforspeechandocr(this.titulo, this.cuerpo);
}

class CuerpoTexto extends Cuerpo {
  @override
  String tipo;
  String texto;

  CuerpoTexto({required this.tipo, required this.texto});

  factory CuerpoTexto.fromMap(Map<String, dynamic> json) {
    return CuerpoTexto(tipo: json['tipo'], texto: json['texto']);
  }

  @override
  String obtenerDato<String>() {
    return texto as String;
  }

  Map<String, dynamic> toMap() {
    return {'tipo': 'Texto Plano', 'texto': texto};
  }
}

class ServicioModificarnota {
  Future<void> modificar(Note Notamodificada) async {
    final url = Uri.parse('http://192.168.0.103:3000/nota');
    List<Map<String, dynamic>> cuerposMap =
        Notamodificada.cuerpo.map((c) => c.toMap()).toList();

    final response = await http.patch(
      url,
      body: json.encode({
        'id': Notamodificada.notaId,
        'fechaActualizacion': DateTime.now().toString(),
        'titulo': Notamodificada.titulo,
        'cuerpo': cuerposMap,
        'usuarioId': Notamodificada.usuarioId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Nota creada exitosamente');
    } else {
      print('Error al crear la nota');
    }
  }
}

class Note {
  String notaId;
  String titulo;
  List<Cuerpo> cuerpo;
  DateTime fechaCreacion;
  DateTime? fechaEliminacion;
  DateTime fechaActualizacion;
  num? latitud;
  num? altitud;
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
    final document = parse(cuerpo[0].obtenerDato());
    final plainText = document.body?.text ?? '';

    return plainText;
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
        continue;
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
          : num.parse(json['latitud']['value'].toString()),
      altitud: json['altitud']['value'] == null
          ? null
          : num.parse(json['altitud']['value'].toString()),
      usuarioId: json['usuarioId'],
    );
  }
}

class Optional<T> {
  T? value;
  bool assign = false;

  Optional([T? v]) {
    if (v != null) {
      assign = true;
      value = v;
    }
  }

  bool hasValue() {
    return assign;
  }

  T getValue() {
    if (assign) {
      return value!;
    } else {
      throw Exception("Mal uso de la abstraccion OPTIONAL");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value is DateTime ? getValue() : null,
      'assign': assign,
    };
  }
}

class CreateNotaDto {
  String titulo;
  List<Cuerpo> cuerpo;
  Optional<num> latitud;
  Optional<num> altitud;
  String usuarioId;

  CreateNotaDto(this.titulo, this.cuerpo, this.latitud, this.altitud,
      {this.usuarioId = 'user1'});

  Future<void> crearNota() async {
    final url = Uri.parse('http://192.168.0.103:3000/nota');
    List<Map<String, dynamic>> cuerposMap =
        cuerpo.map((c) => c.toMap()).toList();

    final response = await http.post(
      url,
      body: json.encode({
        'titulo': titulo,
        'cuerpo': cuerposMap,
        'fechaCreacion': DateTime.now().toString(),
        'fechaActualizacion': DateTime.now().toString(),
        if(latitud.hasValue())
        'latitud': latitud.getValue(),
        if(altitud.hasValue())
        'altitud': altitud.getValue(),
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
