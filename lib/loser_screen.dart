import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'home_screen.dart';

class LoserScreen extends StatelessWidget {
  const LoserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const textColor = Colors.white;
    const buttonColor = Colors.red;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perdiste'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                  size: screenHeight * 0.1,
                ),
                SizedBox(height: screenHeight * 0.05),
                Text('Perdiste!',
                    style: TextStyle(
                        fontSize: screenHeight * 0.036,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Mejor suerte la próxima vez',
                  style: TextStyle(fontSize: screenHeight * 0.018),
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    gameState.resetGame();
                    Navigator.pop(context);
                  },
                  child: const Text('Volver a jugar'),
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
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ));
  }
}
