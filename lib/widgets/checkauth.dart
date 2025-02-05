import 'package:flutter/material.dart';
import 'package:flutteraula04/pages/autenticacao_page.dart';
import 'package:flutteraula04/pages/home_page.dart';
import 'package:flutteraula04/service/auth_service.dart';
import 'package:get/get.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Verifica se o usuário está autenticado e retorna a página correspondente
      return AuthService.to.userIsAuthenticated.value
          ? const HomePage()
          : const AutenticacaoPage();
    });
  }
}