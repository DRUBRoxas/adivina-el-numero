import 'package:adivina_el_numero/screens/difficulty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/game_state.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;

    if (gameState.playerName != '') {
      _controller.text = gameState.playerName;
    }

    return Scaffold(
        body: Consumer<GameState>(builder: (context, gameState, child) {
      return Center(
        child: Column(
          children: <Widget>[
            const Spacer(flex: 2),
            Text(
              'No es suerte, adivina!',
              style: TextStyle(fontSize: screenHeight * 0.03),
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Introduce tu nombre',
                    labelStyle: TextStyle(fontSize: screenHeight * 0.02),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu nombre';
                    } else if (value.length > 15) {
                      return 'El nombre no puede tener más de 15 letras';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    gameState.setPlayerName(_controller.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DifficultyScreen()),
                    );
                  }
                },
                child: Text(
                  'Jugar!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      );
    }));
  }
}
