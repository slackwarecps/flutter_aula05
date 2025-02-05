import 'package:firebase_core/firebase_core.dart'; // Importa o pacote necessário para inicializar o Firebase.
import 'package:flutter/material.dart'; // Importa o pacote principal do Flutter para criar interfaces de usuário.
import 'package:flutteraula04/service/auth_service.dart';
import 'package:get/get.dart'; // Importa o pacote GetX para gerenciamento de estado, injeção de dependência e navegação.

import '../controllers/theme_controller.dart'; // Importa o controlador de tema personalizado da aplicação.

/// Função responsável por inicializar as configurações principais do aplicativo.
/// 
/// Esta função é chamada no início da execução do aplicativo para garantir que
/// todas as dependências e configurações necessárias estejam prontas antes de
/// o aplicativo ser exibido ao usuário.
initConfigurations() async {
  // Garante que o Flutter esteja completamente inicializado antes de executar qualquer código.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase, que é usado para autenticação, banco de dados, etc.
  await Firebase.initializeApp();

  // Registra o `ThemeController` no GetX para injeção de dependência.
  // O `lazyPut` cria a instância do controlador apenas quando ele é acessado pela primeira vez.
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<AuthService>(() => AuthService());
}