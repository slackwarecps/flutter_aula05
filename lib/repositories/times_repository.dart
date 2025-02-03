import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_aula04/database/db.dart';
import 'package:flutter_aula04/models/time.dart';
import 'package:flutter_aula04/models/titulo.dart';

class TimesRepository extends ChangeNotifier {
  // Lista privada e imutável para proteger os dados
  final List<Time> _times = [];

  // Retorna uma lista imutável para evitar alterações externas
  UnmodifiableListView<Time> get times => UnmodifiableListView(_times);

  // Construtor para inicializar os times
  TimesRepository() {
    _initializeRepository();
  }

  // Inicializa o repositório carregando os times do banco de dados
  Future<void> _initializeRepository() async {
    var db = await DB.get();
    List<Map<String, dynamic>> timesData = await db.query('times');

    for (var timeData in timesData) {
      _times.add(
        Time(
          id: timeData['id'],
          nome: timeData['nome'],
          brasao: timeData['brasao'],
          pontos: timeData['pontos'],
          cor: _parseColor(timeData['cor']),
          titulos: await _fetchTitulos(timeData['id']),
        ),
      );
    }
    notifyListeners();
  }

  // Método privado para converter a string de cor em um objeto Color
Color _parseColor(String? colorString) {
  if (colorString == null || colorString.isEmpty) {
    return Colors.transparent; // Retorna uma cor padrão caso a string seja inválida
  }
  try {
    return Color(int.parse(colorString));
  } catch (e) {
    debugPrint('Erro ao converter a cor: $e');
    return Colors.transparent; // Retorna uma cor padrão em caso de erro
  }
}

  // Método para buscar os títulos de um time específico
  Future<List<Titulo>> _fetchTitulos(int timeId) async {
    var db = await DB.get();
    List<Map<String, dynamic>> results = await db.query(
      'titulos',
      where: 'time_id = ?',
      whereArgs: [timeId],
    );

    return results
        .map(
          (tituloData) => Titulo(
            id: tituloData['id'],
            campeonato: tituloData['campeonato'],
            ano: tituloData['ano'],
          ),
        )
        .toList();
  }

  // Método para adicionar um título a um time específico
  Future<void> addTitulo({required Time time, required Titulo titulo}) async {
    var db = await DB.get();
    int id = await db.insert('titulos', {
      'campeonato': titulo.campeonato,
      'ano': titulo.ano,
      'time_id': time.id,
    });

    titulo.id = id;
    time.titulos.add(titulo);
    notifyListeners();
  }

  // Método para editar um título existente
  Future<void> editTitulo({
    required Titulo titulo,
    required String ano,
    required String campeonato,
  }) async {
    var db = await DB.get();
    await db.update(
      'titulos',
      {
        'campeonato': campeonato,
        'ano': ano,
      },
      where: 'id = ?',
      whereArgs: [titulo.id],
    );

    titulo
      ..ano = ano
      ..campeonato = campeonato;
    notifyListeners();
  }

  // Método estático para configurar os times iniciais
  static List<Time> setupTimes() {
    return [
      Time(
        id: 1,
        nome: 'Ponte Preta',
        brasao: 'https://i.imgur.com/0Y1b8Xv.png',
        pontos: 100,
        cor: const Color.fromARGB(255, 102, 102, 103),
        titulos: [],
      ),
      Time(
        id: 2,
        nome: 'Flamengo',
        brasao: 'https://i.imgur.com/R7ewqu7.gif',
        pontos: 69,
        cor: Colors.red,
        titulos: [],
      ),
      Time(
        id: 3,
        nome: 'Guarani',
        brasao: 'https://i.imgur.com/wYTCtRu.jpeg',
        pontos: 10,
        cor: Colors.green,
        titulos: [],
      ),
      Time(
        id: 4,
        nome: 'São Paulo',
        brasao: 'https://i.imgur.com/Ejn0Yvi.gif',
        pontos: 10,
        cor: Colors.pinkAccent,
        titulos: [],
      ),
    ];
  }
}