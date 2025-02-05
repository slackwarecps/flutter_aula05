import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  // Estado reativo para o tema
  var isDark = false.obs;

  // Mapeamento de temas
  final Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  // Caixa do Hive para persistência
  late Box _preferencesBox;

  // Singleton para acessar o controlador
  static ThemeController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _initializeHiveBox();
  }

  // Inicializa a caixa do Hive
  Future<void> _initializeHiveBox() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      _preferencesBox = await Hive.openBox('preferencias', path: dir.path);
      await loadThemeMode();
    } catch (e) {
      print('Erro ao inicializar o Hive: $e');
    }
  }

  // Carrega o tema salvo
  Future<void> loadThemeMode() async {
    try {
      String themeText = _preferencesBox.get('theme') ?? 'light';
      isDark.value = themeText == 'dark';
      setMode(themeText);
    } catch (e) {
      print('Erro ao carregar o tema: $e');
    }
  }

  // Define o modo de tema
  Future<void> setMode(String themeText) async {
    try {
      ThemeMode? themeMode = themeModes[themeText];
      if (themeMode != null) {
        Get.changeThemeMode(themeMode);
        await _preferencesBox.put('theme', themeText);
      }
    } catch (e) {
      print('Erro ao definir o tema: $e');
    }
  }

  // Alterna entre os temas claro e escuro
  void changeTheme() {
    final newTheme = isDark.value ? 'light' : 'dark';
    isDark.value = !isDark.value;
    setMode(newTheme);
  }
}