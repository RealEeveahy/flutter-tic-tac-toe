import 'package:flutter/material.dart';
import 'package:tic_tac_toe/viewmodel/game_updates.dart';
import 'package:tic_tac_toe/viewmodel/styles.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: List.generate(9, (index) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: SquarePointer(context, index).view,
                    );
                  }),
                )
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                    child: Text("Undo")
                    ),
                  MainButton(
                    child: Text("Restart")
                    )
                ],
              ),
              updateHandler.generateWinLabel(),
            ]
          )
        )
      );
  }
}