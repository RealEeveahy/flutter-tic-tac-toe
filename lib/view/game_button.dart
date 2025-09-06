//import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';
import 'package:flutter/material.dart';
import '../viewmodel/game_updates.dart';
import 'package:tic_tac_toe/viewmodel/square_pointer.dart';

class GameButton extends StatefulWidget {
  final SquarePointer parent;
  late _GameButtonState currentState;

  GameButton({super.key, required this.parent});

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
        updateHandler.SquareClicked(widget.parent, context);
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