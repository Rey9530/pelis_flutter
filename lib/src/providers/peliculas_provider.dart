import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProviders {
  String _apikey = 'c73acda1ba7a0ab0fe617e111502ee4a';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamControlers =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamControlers.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamControlers.stream;

  void disposeStreams() {
    _popularesStreamControlers.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData["results"]);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      'api_key': _apikey,
      'language': _languaje,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopular() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apikey,
      'language': _languaje,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;

    return resp;
  }
}
