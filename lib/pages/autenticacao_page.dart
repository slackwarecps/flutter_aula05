import 'package:flutter/material.dart';
import 'package:flutteraula04/pages/autenticacao_controller.dart';
import 'package:get/get.dart';

class AutenticacaoPage extends StatelessWidget {
  const AutenticacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializa o controlador apenas quando necessário
    final AutenticacaoController controller = Get.put(AutenticacaoController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.titulo.value)), // Título dinâmico
        actions: [
          TextButton(
            onPressed: controller.toogleRegistrar, // Alterna entre login e registro
            child: Obx(() => Text(
              controller.appBarButton.value,
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.senha,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (controller.formKey.currentState?.validate() ??
                                false) {
                              controller.isLogin.value
                                  ? controller.login()
                                  : controller.registrar();
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(controller.botaoPrincipal.value),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}