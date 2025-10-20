import 'package:mimpedir/tipo.dart';

import 'usuario.dart';


class Restaurante{
  int? _codigo;
  String? _nomeRestaurante;
  String? _latitude;
  String? _longitude;
  Usuario? _proprietario;
  Type?  _tipodeCulinaria;

  Restaurante({int? codigo, String? nomeRestaurante, latitude, longitude, required Tipo culinaria}){
    _codigo = codigo;
    _nomeRestaurante = nomeRestaurante;
    _latitude = latitude;
    _longitude = longitude;
  }

  //get nome => null;
  //get codigo => null;

  String? get latitude => _latitude;

  set latitude(String? value) {
    _latitude = value;
  }

  String? get longitude => _longitude;

  set longitude(String? value) {
    _longitude = value;
  }

  String? get nomeRestaurante => _nomeRestaurante;

  set nomeRestaurante(String? value) {
    _nomeRestaurante = value;
  }

  int? get codigo => _codigo;

  get culinaria => null;
  set codigo(int? value){ _codigo = value;}
}