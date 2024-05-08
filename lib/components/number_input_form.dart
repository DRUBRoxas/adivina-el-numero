import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game_state.dart';

class NumberInputForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const NumberInputForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  _NumberInputFormState createState() => _NumberInputFormState();
}

class _NumberInputFormState extends State<NumberInputForm> {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final formWidth = screenWidth * 0.5;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: formWidth,
        child: TextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            labelText: 'Introduce un número',
            labelStyle: TextStyle(fontSize: screenHeight * 0.02),
            errorStyle: TextStyle(fontSize: screenHeight * 0.02),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor introduce un número';
            }
            int num = int.parse(value);
            if (num > gameState.max) {
              return 'El número introducido está fuera del rango';
            }
            return null;
          },
        ),
      ),
    );
  }
}
