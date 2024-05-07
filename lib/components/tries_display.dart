import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game_state.dart';

class TriesDisplay extends StatelessWidget {
  const TriesDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight * 0.024;

    return Text(
      'Intentos restantes: ${gameState.tries}',
      style: TextStyle(fontSize: fontSize),
    );
  }
}
