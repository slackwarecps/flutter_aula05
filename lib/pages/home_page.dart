import 'package:flutter/material.dart';
import 'package:flutteraula04/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutteraula04/models/time.dart';
import 'package:flutteraula04/pages/time_page.dart';
import 'package:flutteraula04/repositories/times_repository.dart';
import 'package:flutteraula04/widgets/brasao.dart';
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
          PopupMenuButton(icon:const Icon(Icons.more_vert),itemBuilder: (_)=>[
            PopupMenuItem(child: ListTile(
              leading: Obx(()=> controller.isDark.value 
              ? const Icon(Icons.brightness_7)
              : const Icon(Icons.brightness_2)),
              title: Obx(() => controller.isDark.value? const Text('Light'):const Text('Dark'),),
              onTap: ()=> controller.changeTheme(),
            )),
                   PopupMenuItem(child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                AuthService.to.logout();
              },
            )),
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
