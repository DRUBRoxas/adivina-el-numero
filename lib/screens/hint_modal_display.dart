import 'package:adivina_el_numero/model/game_state.dart';
import 'package:flutter/material.dart';

import '../model/hint_enum.dart';

class HintModalDisplay extends StatelessWidget {
  final GameState gameState;
  const HintModalDisplay({Key? key, required this.gameState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: Pistas.values.map((pista) {
        return ListTile(
          title: Text(pista.nombre),
          onTap: () {
            String hint = pista.funcion(gameState.numberToGuess);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              gameState.setHint(hint);
              Navigator.of(context).pop();
            });
          },
        );
      }).toList(),
    );
  }
}
