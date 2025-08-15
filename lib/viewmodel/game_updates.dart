//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/view/game_button.dart';
import '../game.dart';
import '../model/game_ai.dart';

GameUpdates updateHandler = GameUpdates();


///
/// Defines logic that is interacted with through the user interface.
/// This includes menu choices and gameplay
///
class GameUpdates 
{
  void StartMatch(int difficulty)
  {
    if(difficulty == -1)
    {
      //2 player match
      game.currentMatch = Match();
    }
    else
    {
      //vs ai match
      game.currentMatch = Match.aiMatch(ArtificialPlayer(difficulty));
    }
  }

  /// Called by the GameButton widget when it is clicked. Triggers the logic for a player move.
  void SquareClicked(SquarePointer sq, BuildContext context)
  {
    //if the square is empty, register the players move, else do nothing
    if(sq.model.isEmpty() && game.currentMatch!.playerCanMove())
    {
      //register a new move with the appropriate player
      sq.model.RegisterMove(game.currentMatch!.p1turn ? "X" : "O");

      //toggle the turn to the other player
      game.currentMatch!.p1turn = !game.currentMatch!.p1turn; 

      //if the second player is ai, automatically make a move
      if(game.currentMatch!.AIPlayer != null) 
      {
        game.currentMatch!.AIPlayer!.AIMove();
      }
    }
  }

  void SquareChanged(String newString, GameButton square)
  {
    square.currentState.updateContent(newString); // update the button to display the new content
  }
}

class SquarePointer
{
  late GameButton view;
  late GameSquare model;
  SquarePointer(BuildContext context, int index)
  {
    model = GameSquare(index, this); // create the model that will handle button logic
    view = GameButton(parent: this); // create the button that will be displayed in the gridview
  }
}