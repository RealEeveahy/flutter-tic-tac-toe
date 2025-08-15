import 'package:flutter/material.dart';
import 'package:tic_tac_toe/viewmodel/styles.dart';
import '../viewmodel/navigation.dart';

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
                  Text(
                    "Wins: 0"
                  ),
                  SizedBox( width:50 ),
                  Text(
                    "Losses: 0"
                  )
                ],
              )
            ],
          ),
        )
      );
  }
}