import 'package:flutter/material.dart';
import 'package:tic_tac_toe/viewmodel/styles.dart';
import '../viewmodel/navigation.dart';
import '../viewmodel/game_updates.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        updateHandler.StartMatch(0);
                      },
                      child : MainTextStyle(content:'Easy')
                    ),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 200,
                  child: MainButton(
                    onPressed: () {
                      nav.ToGame(context);
                      updateHandler.StartMatch(1);
                    },
                    child : MainTextStyle(content:'Medium')
                  ),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 200,
                  child: MainButton(
                    onPressed: () {
                      nav.ToGame(context);
                      updateHandler.StartMatch(2);
                    },
                    child : MainTextStyle(content:'Hard')
                  ),
                ),
              ],
            ),
          ),
        )
      );
  }
}