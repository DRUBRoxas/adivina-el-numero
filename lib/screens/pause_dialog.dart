import 'package:adivina_el_numero/screens/difficulty_screen.dart';
import 'package:adivina_el_numero/screens/score_dialog.dart';
import 'package:adivina_el_numero/model/score_manager.dart';
import 'package:flutter/material.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight * 0.02;

    return Dialog(
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Pausa',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.stop_circle_outlined),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    '¿Estás seguro de que quieres terminar el juego?',
                                    style: TextStyle(fontSize: fontSize)),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar',
                                        style: TextStyle(fontSize: fontSize)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DifficultyScreen()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text('Sí',
                                        style: TextStyle(fontSize: fontSize)),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                    Text('Terminar', style: TextStyle(fontSize: fontSize)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.play_circle_outline_outlined),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text('Continuar', style: TextStyle(fontSize: fontSize)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.scoreboard_outlined),
                      onPressed: () {
                        var scores = ScoreManager.loadBestScores();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ScoresDialog(
                              scoresFuture: scores,
                            );
                          },
                        );
                      },
                    ),
                    Text('Scores', style: TextStyle(fontSize: fontSize)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
