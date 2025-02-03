import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_aula04/models/time.dart';
import 'package:flutter_aula04/pages/time_page.dart';
import 'package:flutter_aula04/repositories/times_repository.dart';
import 'package:flutter_aula04/widgets/brasao.dart';
import '../controllers/theme_controller.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();

  
  }
  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 239, 9),
        title: const Text('Brasileirao Aula 05'),
        actions: [
          PopupMenuButton(icon:Icon(Icons.more_vert),itemBuilder: (_)=>[
            PopupMenuItem(child: ListTile(
              leading: Obx(()=> controller.isDark.value 
              ? Icon(Icons.brightness_7)
              : Icon(Icons.brightness_2)),
              title: Obx(() => controller.isDark.value? Text('Light'):Text('Dark'),),
              onTap: ()=> controller.changeTheme(),
            ))
          ],)
        ],
      ),
      body: Consumer<TimesRepository>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.times.length,
            itemBuilder: (BuildContext contexto, int time) {
              final List<Time> tabela = repositorio.times;
              return ListTile(
                leading: Brasao(
                  image: tabela[time].brasao,
                  width: 100,
                ),
                title: Text(tabela[time].nome),
                subtitle: Text('Titulos: ${tabela[time].titulos.length}'),
                trailing: Text(tabela[time].pontos.toString()),
                onTap: () {
                  Get.to(() => TimePage(
                        key: Key(tabela[time].nome),
                        time: tabela[time],
                      ));
                },
              );
            },
            separatorBuilder: (_, ___) => const Divider(),
            padding: const EdgeInsets.all(16),
          );
        },
      ),
    );
  }
}
