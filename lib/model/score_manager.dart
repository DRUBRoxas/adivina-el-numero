import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static const String _keyBestScores = 'bestScores';
  static const int _maxScores = 20;

  ScoreManager._internal();

  static final ScoreManager _singleton = ScoreManager._internal();

  factory ScoreManager() {
    return _singleton;
  }

  // Guardar las mejores puntuaciones
  static Future<void> saveBestScores(List<Map<String, dynamic>> scores) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = scores.map((score) => jsonEncode(score)).toList();
    prefs.setStringList(_keyBestScores, jsonList);
  }

  // Recuperar las mejores puntuaciones
  static Future<List<Map<String, dynamic>>> loadBestScores() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_keyBestScores);
    if (jsonList != null) {
      return jsonList
          .map((jsonScore) => jsonDecode(jsonScore))
          .toList()
          .cast<Map<String, dynamic>>();
    } else {
      return []; // Retorna una lista vacía si no hay puntuaciones guardadas
    }
  }

  // Añadir una nueva puntuación
  static Future<void> newScore(String name, int score) async {
    final List<Map<String, dynamic>> currentScores = await loadBestScores();

    currentScores.add({'name': name, 'score': score});
    currentScores.sort((a, b) =>
        b['score'].compareTo(a['score'])); // Ordenar por puntuación descendente

    if (currentScores.length > _maxScores) {
      currentScores.removeRange(_maxScores,
          currentScores.length); // Mantener solo las primeras 20 puntuaciones
    }

    await saveBestScores(currentScores);
  }
}
