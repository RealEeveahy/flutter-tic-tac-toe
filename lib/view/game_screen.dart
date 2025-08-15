import 'package:flutter/material.dart';
import 'package:tic_tac_toe/viewmodel/game_updates.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),


        body: SizedBox(
          width: 300,
          child: GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.zero,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 1,
            children: List.generate(9, (index) {
              return SizedBox(
                width: 100,
                height: 100,
                child: SquarePointer(context, index).view,
              );
            }),
          )
        )
      );
  }

}