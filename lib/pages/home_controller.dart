// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_aula04/models/time.dart';
import 'package:flutter_aula04/repositories/times_repository.dart';

class HomeController {
  // Tornar a variável `timesRepository` final para indicar que ela não será reatribuída após a inicialização.
  final TimesRepository timesRepository;

  // Getter para acessar a tabela de times de forma segura.
  List<Time> get tabela => timesRepository.times;

  // Usar inicialização no construtor para garantir que `timesRepository` seja inicializado corretamente.
  HomeController() : timesRepository = TimesRepository();
}