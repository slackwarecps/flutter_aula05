import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutteraula04/models/titulo.dart';
import 'package:flutteraula04/repositories/times_repository.dart';

class EditTituloPage extends StatefulWidget {
  Titulo titulo;
  EditTituloPage({super.key, required this.titulo});

  @override
  State<EditTituloPage> createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
    //Controllers para os campos do formulário
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final  _formKey = GlobalKey<FormState>();



@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  editar(){
        // Recuperar as info sem ouvir o repositorio no caso de salvar
    // False = vai apenas salvar e nao vai reeenderizar nada.
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
      titulo:widget.titulo,
        campeonato: _campeonato.text,
        ano: _ano.text,
  
    );

    Get.back();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Titulo'),
        backgroundColor: const Color.fromARGB(255, 187, 187, 187),
        actions:[IconButton(onPressed: editar, icon: const Icon(Icons.check))]
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ano',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o ano do titulo!';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um ano válido.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: TextFormField(
                controller: _campeonato,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Campeonato',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o Campeonato!';
                  }
                  return null;
                },
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}