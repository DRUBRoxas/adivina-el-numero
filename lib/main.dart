import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/game_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        title: 'No es suerte, advina!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      )));
}
