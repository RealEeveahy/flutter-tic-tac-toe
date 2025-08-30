import 'package:flutter/material.dart';
import 'package:tic_tac_toe/viewmodel/styles.dart';
import '../viewmodel/navigation.dart';
import '../viewmodel/game_updates.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox( height: 200),
              Text(
                "Welcome to Tic-Tac-Toe!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox( height: 100 ),
              SizedBox(
                width: 300,
                height: 100,
                child: ElevatedButton(
                onPressed : () {
                  nav.ModeSelect(context);
                }, 
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue[300]),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                child: MainTextStyle(content:"Play"),
                ),
              ),
              SizedBox( height: 100 ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  updateHandler.NewStatLabel("Wins"),
                  SizedBox( width:50 ),
                  updateHandler.NewStatLabel("Losses"),
                  SizedBox( width:50 ),
                  updateHandler.NewStatLabel("Draws"),
                ],
              )
            ],
          ),
        )
      );
  }
}