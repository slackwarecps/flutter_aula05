import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_aula04/models/time.dart';
import 'package:flutter_aula04/repositories/times_repository.dart';
import '../models/titulo.dart';

// Pagina/Componente Visual
// pagina de Add Titulo
class AddTituloPage extends StatefulWidget {
  Time time;

  AddTituloPage({super.key, required this.time});

  @override
  State<AddTituloPage> createState() => _AddTituloPageState();
}

// Controle de Estado
class _AddTituloPageState extends State<AddTituloPage> {
  //Controllers para os campos do formulário
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  save() {
    // Recuperar as info sem ouvir o repositorio no caso de salvar
    // False = vai apenas salvar e nao vai reeenderizar nada.
    Provider.of<TimesRepository>(context, listen: false).addTitulo(
      time: widget.time,
      titulo: Titulo(
        id:-1,
        campeonato: _campeonato.text,
        ano: _ano.text,
      ),
    );

    Get.back();

    Get.snackbar('Sucesso', 'Cadastro com sucesso!',
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.time.cor,
        title: const Text('Adicionar Titulo'),
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
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    save();
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
