import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game_state.dart';

class LowerBoundDisplay extends StatelessWidget {
  const LowerBoundDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight * 0.024;
    final iconSize = screenHeight * 0.03;
    const iconColor = Colors.red;

    return gameState.lowerBound != null
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${gameState.lowerBound}',
                    style: TextStyle(fontSize: fontSize)),
                Icon(Icons.arrow_upward, size: iconSize, color: iconColor),
              ],
            ),
          )
        : Container();
  }
}
