import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),

        // The body of the screen appears below the AppBar.
        // Since there's no Center widget wrapping this,
        // the text will be aligned to the top-left by default.
        body: Text(
          'Dice and Dungeons!',
          // TextStyle allows us to change how the text looks.
          // Here we set the font size to 24.
          style: TextStyle(fontSize: 24),
        ),
      ),
    ),
  );
}