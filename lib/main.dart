import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(MaterialApp(home: MainScreen()));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),

        body: ListView(
          children: [
            OutlinedButton(
                onPressed: () {
                  controls.PlayerSelected(false, context);
                },
                style: ButtonStyle( shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),),
                child : Text('Vs Player 2')
              ),
              OutlinedButton(
                onPressed: () {
                  controls.PlayerSelected(true, context);
                },
                style: ButtonStyle( shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),),
                child : Text('Vs Computer')
              ),
          ],
        )
      );
  }
}

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),

        body: ListView(
          children: [
            OutlinedButton(
                onPressed: () {
                  controls.DifficultySelected(0, context);
                },
                style: ButtonStyle( shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),),
                child : Text('Easy')
              ),
              OutlinedButton(
                onPressed: () {
                  controls.DifficultySelected(1, context);
                },
                style: ButtonStyle( shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),),
                child : Text('Medium')
              ),
              OutlinedButton(
                onPressed: () {
                  controls.DifficultySelected(2, context);
                },
                style: ButtonStyle( shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),),
                child : Text('Hard')
              )
          ],
        )
      );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),

        body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child : GameSquare(index, context).myButton
            ),
            );
          })
        )
      );
  }

}

class GameButton extends StatefulWidget {
  const GameButton({super.key});

  @override
  State<GameButton> createState() => _ButtonTextState();
}

class _ButtonTextState extends State<GameButton> {
  String content = 'X';

  void changeContent(String newContent)
  {
    content = newContent;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {      
        setState(() {
          content;
        });
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
      child : Text(content)
    );
  }
}