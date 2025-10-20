import 'package:flutter/material.dart';
import 'package:mimpedir/banco/restaurante_DAO.dart';
import 'package:mimpedir/restaurante.dart';
import 'package:mimpedir/tipo.dart';

import 'banco/tipo_DAO.dart';

class TelaEditarRestaurante extends StatefulWidget{
  static Restaurante restaurante = Restaurante(culinaria: Tipo());

  @override
  State<StatefulWidget> createState() {
    return TelaEditarRestauranteState();
  }
}

class TelaEditarRestauranteState extends State<TelaEditarRestaurante>{

  final TextEditingController cdController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  String? culinariaSelecionada;
  List<Tipo> tiposCulinaria =[];
  int? tipoCulinaria;
  int? codigo = TelaEditarRestaurante.restaurante.codigo as int;

  void intState(){
    super.initState();
    carregarTipos();
    cdController.text = TelaEditarRestaurante.restaurante.codigo.toString()!;
    nomeController.text = TelaEditarRestaurante.restaurante.nomeRestaurante!;
    latitudeController.text = TelaEditarRestaurante.restaurante.latitude.toString()!;
    longitudeController.text = TelaEditarRestaurante.restaurante.longitude.toString()!;
    tipoCulinaria = TelaEditarRestaurante.restaurante.culinaria?.codigo!;
    culinariaSelecionada = TelaEditarRestaurante.restaurante.culinaria?.descricao!;
  }

  Future<void> carregarTipos() async{
    final lista = await TipoDAO.listarTipos();
    setState(() {
      tiposCulinaria = lista;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Atualizar Restaurante")),
      body: Padding(padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Informações do Restaurante: "),
              SizedBox(height:40),
              Text('Código'),
              TextFormField(
                decoration: InputDecoration(hintText: 'Código'),
                validator: (String? value){},
                controller: cdController,
                enabled: false,
              ),
              Text("Tipo de comida: "),
              DropdownButtonFormField<String>(
                  value: culinariaSelecionada,
                  items: tiposCulinaria.map((tipo){
                    return DropdownMenuItem<String>(
                        value: tipo.descricao,
                        child: Text("${tipo.descricao}")
                    );
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      culinariaSelecionada = value;
                      Tipo tipoSelecionado = tiposCulinaria.firstWhere(
                            (tipo) => tipo.nome == value,
                      );
                      tipoCulinaria = tipoSelecionado.codigo;
                    });
                  }
              ),

              TextFormField(
                decoration: const InputDecoration(hintText: 'Nome do Restaurante'),
                validator: (String? value) {},
                controller: nomeController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Latitude'),
                validator: (String? value) {},
                controller: latitudeController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Longitude'),
                validator: (String? value) {},
                controller: longitudeController,
              ),
              ElevatedButton(
                  onPressed: ()async{
                    final sucesso = await RestauranteDAO.cadastrarRestaurante(nomeController.text, latitudeController.text, longitudeController.text, tipoCulinaria);
                    String msg = "Erro: não cadastrado. Verifique os dados.";
                    Color corFundo = Colors.red;

                    if(sucesso > 0){
                      msg = '"${nomeController.text}" atualizado com sucesso! ID: $sucesso';
                      corFundo = Colors.green;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('"${nomeController.text}Atualizado com sucesso! ID: $sucesso'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 5),
                        )
                    );

                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text("Cadastrar")
                    ],
                  ))
            ]
        ),
      ),
    );
  }
}