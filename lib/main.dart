import 'package:flutter/material.dart';
import 'package:flutteraula04/configuracao/config.dart';
import 'package:flutteraula04/widgets/checkauth.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutteraula04/repositories/times_repository.dart';
import 'controllers/theme_controller.dart';
import 'pages/home_page.dart';


void main() async{
  await initConfigurations();
  // Inicializando o ThemeController com Get.lazyPut
  Get.lazyPut<ThemeController>(() => ThemeController());

  runApp(
    ChangeNotifierProvider(create: (context)=>TimesRepository(),
    child:const MeuAplicativo() ,
  ));
}



class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fabio Pereira',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primaryColor: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light
        ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
        ).copyWith(
          secondary: Colors.white, // Substituto para accentColor
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Substituto para accentIconTheme
        dividerColor: Colors.black45,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent[100],
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const CheckAuth(),
      
    );
  }
}