import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  // Observável para o estado do tema
  final isDark = false.obs;

  // Mapeamento de modos de tema
  final Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  // Instância de SharedPreferences
  //late SharedPreferences _prefs;

  // Singleton para acessar o controlador
  static ThemeController get to => Get.find();

  // Método para carregar o modo de tema salvo
  Future<void> loadThemeMode() async {
    // _prefs = await SharedPreferences.getInstance();
    // final themeText = _prefs.getString('theme') ?? 'light';

    //hive
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('preferencias', path: dir.path);
    String themeText = box.get('theme') ?? 'light';

    isDark.value = themeText == 'dark'?true:false;
    await _setMode(themeText);
  }

  // Método para alterar o modo de tema
  Future<void> _setMode(String themeText) async {
    final themeMode = themeModes[themeText] ?? ThemeMode.light;
    Get.changeThemeMode(themeMode);
    var box = await Hive.openBox('preferencias');
    await box.put('theme',themeText);
   // await _prefs.setString('theme', themeText);
  }

  // Método para alternar entre os temas
  Future<void> changeTheme() async {
    final newTheme = isDark.value ? 'light' : 'dark';
  
    await _setMode(newTheme);
      isDark.value = !isDark.value;
  }
}
