import 'package:flutter/material.dart';
import '../viewmodel/navigation.dart';
import '../viewmodel/styles.dart';
import '../viewmodel/game_updates.dart';

class ModeSelectScreen extends StatelessWidget {
  const ModeSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),

        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: MainButton(
                    onPressed: () {
                      nav.ToGame(context);
                      updateHandler.StartMatch(-1);
                    },
                    child : MainTextStyle(content:'Vs Player 2')
                  ),
              ),
              SizedBox(width: 50),
              SizedBox(
                width: 300,
                height: 300,
                child: MainButton(
                  onPressed: () {
                    nav.DifficultySelect(context);
                  },
                  child : MainTextStyle(content:'Vs Computer')
                ),
              )
            ],
          )
        )
      );
  }
}