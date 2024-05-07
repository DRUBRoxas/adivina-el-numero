import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game_state.dart';

class UpperBoundDisplay extends StatelessWidget {
  const UpperBoundDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight * 0.024;
    final iconSize = screenHeight * 0.03;
    const iconColor = Colors.red;

    return gameState.upperBound != null
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${gameState.upperBound}',
                    style: TextStyle(fontSize: fontSize)),
                Icon(Icons.arrow_downward, size: iconSize, color: iconColor),
              ],
            ),
          )
        : Container();
  }
}
