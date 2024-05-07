import 'package:adivina_el_numero/screens/score_dialog.dart';
import 'package:adivina_el_numero/model/score_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game_state.dart';
import 'home_screen.dart';

class WinnerScreen extends StatelessWidget {
  final int guessedNumber;
  final int totalScore;
  const WinnerScreen(
      {super.key, required this.guessedNumber, required this.totalScore});

  @override
  Widget build(BuildContext context) {
    var gameState = Provider.of<GameState>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenHeight * 0.1;
    final spaceSize = screenHeight * 0.05;
    const textColor = Colors.white;
    const buttonColor = Colors.red;
    ScoreManager.newScore(gameState.playerName, totalScore);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Has acertado!'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.emoji_events_outlined, size: iconSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star_border, size: iconSize * 0.5),
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: Icon(Icons.star_border, size: iconSize * 0.5),
                ),
                Icon(Icons.star_border, size: iconSize * 0.5),
              ],
            ),
            SizedBox(height: spaceSize),
            Text('Has adivinado el número $guessedNumber!',
                style: TextStyle(fontSize: screenHeight * 0.024)),
            SizedBox(height: spaceSize),
            Text('Puntuación: $totalScore',
                style: TextStyle(fontSize: screenHeight * 0.024)),
            SizedBox(height: spaceSize),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: buttonColor,
              ),
              onPressed: () {
                gameState.resetGame();
                Navigator.pop(context);
              },
              child:
                  const Text('Volver a Jugar', style: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: buttonColor,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
              },
              child:
                  const Text('Volver a Inicio', style: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: buttonColor,
              ),
              onPressed: () {
                var scores = ScoreManager.loadBestScores();
                //print all the scores 1 by 1 on console
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ScoresDialog(
                      scoresFuture: scores,
                    );
                  },
                );
              },
              child: const Text('Ver mejores puntuaciones',
                  style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
