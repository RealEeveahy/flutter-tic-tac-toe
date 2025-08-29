import 'package:flutter/material.dart';
import '../viewmodel/navigation.dart';
import '../viewmodel/styles.dart';
import '../viewmodel/game_updates.dart';

class ModeSelectScreen extends StatelessWidget {
  const ModeSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (bool didPop, Object? result) async {
            updateHandler.StatsChanged();
        },
        child: Scaffold(
          appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
          ),
          body: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 200,
                      child: MainButton(
                          onPressed: () {
                            nav.ToGame(context);
                            updateHandler.StartMatch(-1);
                          },
                          child : MainTextStyle(content:'Vs Player 2')
                        ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      height: 200,
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
          )
        )
      );
  }
}