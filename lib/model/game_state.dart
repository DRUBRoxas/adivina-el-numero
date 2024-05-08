import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:adivina_el_numero/model/difficulty_enum.dart';

class GameState extends ChangeNotifier {
  // Attributes
  int _min = 0;
  int _max = 0;
  late int _numberToGuess;
  int? _upperBound;
  int? _lowerBound;
  Timer? _timer;
  late int _timeLimit;
  late int _timeRemaining;
  late int _tries;
  late int _score;
  late int _scoreMultiplier;
  String _playerName = '';
  late Dificultad _difficulty;
  String _hint = '';
  bool _hintUsed = false;
  // Private constructor
  GameState._internal();

  // Singleton instance
  static final GameState _singleton = GameState._internal();

  // Factory constructor
  factory GameState() {
    return _singleton;
  }

  // Getters
  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;
  int? get upperBound => _upperBound;
  int? get lowerBound => _lowerBound;
  int get timeRemaining => _timeRemaining;
  int? get tries => _tries;
  String get playerName => _playerName;
  Dificultad get difficulty => _difficulty;
  int get score => _score;
  String get hint => _hint;
  bool get hintUsed => _hintUsed;
  // Methods
  void resetGame() {
    _min = _difficulty.min;
    _max = _difficulty.max;
    _numberToGuess = _min + Random().nextInt(_max - _min + 1);
    _upperBound = null;
    _lowerBound = null;
    _timeLimit = _difficulty.tiempo;
    _timeRemaining = _timeLimit * 60;
    _timer?.cancel();
    _tries = _difficulty.intentos;
    _score = 0;
    _hint = '';
    _hintUsed = false;
    _scoreMultiplier = _difficulty.multiplicadorScore;
    startTimer();
    notifyListeners();
  }

  void setDifficulty(Dificultad difficulty) {
    _difficulty = difficulty;
    resetGame();
  }

  void setHint(String hint) {
    _hintUsed = true;
    _hint = hint;
    notifyListeners();
  }

  void setUpperBound(int value) {
    _upperBound = value;
    notifyListeners();
  }

  void setLowerBound(int value) {
    _lowerBound = value;
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining == 0) {
        timer.cancel();
      } else {
        _timeRemaining--;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

  void decreaseTries() {
    _tries = _tries - 1;
    notifyListeners();
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  void calculateScore() {
    if (!_hintUsed) {
      _score = _score +
          (_timeRemaining * _scoreMultiplier) +
          (_difficulty.intentos - _tries) * _scoreMultiplier;
    } else {
      _score = _score +
          (_timeRemaining * _scoreMultiplier) +
          (_difficulty.intentos - _tries) * _scoreMultiplier;
      _score = _score ~/ 2;
    }

    notifyListeners();
  }
}
