import 'package:flutter/material.dart';

enum Dificultad {
  facil("Fácil", 5, 1, 0, 10, 1),
  medio("Medio", 10, 2, 0, 100, 2),
  dificil("Difícil", 20, 5, 0, 1000, 3);

  const Dificultad(this.nombre, this.intentos, this.tiempo, this.min, this.max,
      this.multiplicadorScore);

  final String nombre;
  final int intentos;
  final int tiempo;
  final int min;
  final int max;
  final int multiplicadorScore;
}
