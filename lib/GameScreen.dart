import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameState.dart';
import 'WinnerScreen.dart';

class GameScreen extends StatefulWidget {
  final int min;
  final int max;

  const GameScreen({super.key, required this.min, required this.max});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String _number = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el número'),
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          return Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _controller,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              labelText: 'Introduce un número',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor introduce un número';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _number = value!;
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20.0,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                int num = int.parse(_number);
                                if (num == gameState.numberToGuess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WinnerScreen(
                                              guessedNumber:
                                                  gameState.numberToGuess,
                                            )),
                                  );
                                } else if (num > gameState.numberToGuess &&
                                    (gameState.upperBound == null ||
                                        num < gameState.upperBound!)) {
                                  gameState.setUpperBound(num);
                                } else if (num < gameState.numberToGuess &&
                                    (gameState.lowerBound == null ||
                                        num > gameState.lowerBound!)) {
                                  gameState.setLowerBound(num);
                                }
                                _controller.clear();
                              });
                            }
                          },
                          shape: const CircleBorder(),
                          child: const Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  if (gameState.upperBound != null)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${gameState.upperBound}',
                              style: const TextStyle(fontSize: 24.0)),
                          const Icon(Icons.arrow_downward,
                              size: 30.0, color: Colors.red),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20.0),
                  if (gameState.lowerBound != null)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${gameState.lowerBound}',
                              style: const TextStyle(fontSize: 24.0)),
                          const Icon(Icons.arrow_upward,
                              size: 30.0, color: Colors.red),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
