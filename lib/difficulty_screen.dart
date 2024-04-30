import 'package:flutter/material.dart';
import 'package:adivina_el_numero/difficulty_enum.dart';
import 'package:adivina_el_numero/game_screen.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({Key? key});

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> {
  Dificultad? dificultadSeleccionada;

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;
    const buttonColor = Colors.red;

    return Scaffold(
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          return SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Selecciona la dificultad',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: Dificultad.values.length,
                        itemBuilder: (context, index) {
                          final dificultad = Dificultad.values[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 90.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  dificultad.nombre,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.info,
                                      color: Colors.blue),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            dificultad.nombre,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Rango: ${dificultad.min}-${dificultad.max}\n'
                                              'Tiempo: ${dificultad.tiempo} minutos\n'
                                              'Intentos: ${dificultad.intentos}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                          backgroundColor: Colors.grey[200],
                                        );
                                      },
                                    );
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    dificultadSeleccionada = dificultad;
                                  });
                                },
                                selected: dificultad == dificultadSeleccionada,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: textColor,
                      backgroundColor: buttonColor,
                    ),
                    onPressed: dificultadSeleccionada != null
                        ? () {
                            gameState.setDifficulty(dificultadSeleccionada!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GameScreen(),
                              ),
                            );
                          }
                        : null,
                    child: const Text('Comenzar'),
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
