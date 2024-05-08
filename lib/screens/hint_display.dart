import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game_state.dart';

class HintDisplay extends StatelessWidget {
  const HintDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight * 0.024;
    return gameState.hint != ''
        ? Text(
            'Pista: ${gameState.hint}',
            style: TextStyle(fontSize: fontSize),
          )
        : Container();
  }
}
