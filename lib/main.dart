import 'package:flutter/material.dart';
import 'game.dart';
import 'package:provider/provider.dart';

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
                child: GameSquare(index, context).myButton,
              );
            }),
          )
        )
      );
  }

}

class GameButton extends StatefulWidget {
  final GameSquare mySquare;
  late _GameButtonState currentState;

  GameButton({super.key, required this.mySquare});

  @override
  // ignore: no_logic_in_create_state
  State createState() {
    currentState = _GameButtonState();
    return currentState;
  }
}

/// The state for a GameButton Widget
class _GameButtonState extends State<GameButton> {
  String content = "";

  /// Updates the content of the button. 
  /// Called indirectly when the button is clicked, as well as by the AI when it makes a move.
  void updateContent(String newContent) { setState((() { content = newContent; })); }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {      
        controls.GameSquareClicked(widget.mySquare, context);
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
      child : Text(
        content,
        style: TextStyle(
          fontSize: 50,
        )
      )
    );
  }
}