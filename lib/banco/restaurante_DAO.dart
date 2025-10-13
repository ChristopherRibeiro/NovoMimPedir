import 'dart:math';

import 'package:mimpedir/banco/database_helper.dart';
import 'package:mimpedir/banco/usuario_dao.dart';

import '../restaurante.dart';


class RestauranteDAO{
  static Future<List<Restaurante>> listarTodos() async{
    final db = await DatabaseHelper.getDataBase();
    final resultado = await db.query('tb_restaurante',
      where: 'cd_usuario = ?',
      whereArgs: [UsuarioDAO.usuariologado]
    );

    return resultado.map((mapa){
        return Restaurante(
          codigo: mapa['cd_restaurante'] as int,
          nomeRestaurante: mapa['nm_restaurante'] as String

        );
    }).toList();
  }

  static Future<int> cadastrarRestaurante(
      String? nome, String? latitude, String? longitude, int? tipo
      ) async{
    final db = await DatabaseHelper.getDataBase();

    final dadosRestaurante = {
      'nm_restaurante': nome,
      'latitude_restaurante': latitude,
      'longitude_restaurante': longitude,
      'cd_tipo': tipo,
      'cd_usuario': UsuarioDAO.usuariologado.codigo
    };

    try{
      final idRestaurante = await db.insert('tb_restaurante', dadosRestaurante);
      return idRestaurante;
    }catch(a){
      print("Erro ao Cadastrar: $e");
      return -1;
    }

  }

}