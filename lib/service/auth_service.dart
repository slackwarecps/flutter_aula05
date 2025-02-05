import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteraula04/models/time.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  // Instância do FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observável para o usuário autenticado
  final Rx<User?> _firebaseUser = Rx<User?>(null);

  // Observável para verificar se o usuário está autenticado
  final RxBool userIsAuthenticated = false.obs;



  @override
  void onInit() {
    super.onInit();

    // Vincula o stream de mudanças de autenticação ao observável _firebaseUser
    _firebaseUser.bindStream(_auth.authStateChanges());

    // Observa mudanças no _firebaseUser e atualiza o estado de autenticação
    ever<User?>(_firebaseUser, (user) {
      userIsAuthenticated.value = user != null;
    });
  }

  User? get user => _firebaseUser.value;
  static AuthService get to => Get.find<AuthService>();

  // Exibe um Snackbar para mensagens de erro ou sucesso
  void showSnack(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Método para criar um novo usuário
  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showSnack('Erro ao registrar!', e.toString());
    }
  }

  // Método para login
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showSnack('Erro no Login!', e.toString());
    }
  }

  // Método para logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack('Erro ao sair!', e.toString());
    }
  }

  // Método para definir o time do usuário
  Future<void> definirTime(Time time) async {
    final userId = _firebaseUser.value?.uid;

    if (userId == null) {
      showSnack('Erro', 'Usuário não autenticado.');
      return;
    }

    try {
      final db = FirebaseFirestore.instance;
      await db.collection('usuarios').doc(userId).set({
        'time_id': time.id,
        'time_nome': time.nome,
      });
    } catch (e) {
      showSnack('Erro ao definir time', e.toString());
    }
  }
}