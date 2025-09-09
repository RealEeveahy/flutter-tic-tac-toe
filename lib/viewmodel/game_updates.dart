import 'package:tic_tac_toe/view/confetti.dart';
import 'package:tic_tac_toe/view/game_screen.dart';
import 'package:tic_tac_toe/view/user_data_label.dart';
import 'package:tic_tac_toe/view/win_label.dart';
import '../view/game_button.dart';
import '../model/round.dart';
import '../model/game_ai.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'square_pointer.dart';

GameUpdates updateHandler = GameUpdates();

///
/// Defines logic that is interacted with through the user interface.
/// This includes menu choices and gameplay
///
class GameUpdates 
{
  late WinLabel winnerLabel;
  late UserDataCount wins, losses, draws;
  late GameScreen gameScreen;

  Widget NewStatLabel(String name)
  {
    UserDataCount count;
    if(name=="Wins")
    {
      count = UserDataCount(initCount:game.data.wins);
      wins = count;
    }
    else if(name=="Losses")
    {
      count = UserDataCount(initCount:game.data.losses);
      losses = count;
    }
    else
    {
      count = UserDataCount(initCount:game.data.draws);
      draws = count;
    }
    UserDataLabel label = UserDataLabel(labelName: name, child: count);
    return label;
  }

  /// Update all 3 stat labels on the home screen each time one stat changes / a player's data is loaded
  void StatsChanged()
  {
    wins.myState.updateCount(game.data.wins);
    losses.myState.updateCount(game.data.losses);
    draws.myState.updateCount(game.data.draws);
  }

  void StartMatch(int difficulty)
  {
    if(difficulty == -1)
    {
      //2 player match
      game.currentRound = GameRound();
    }
    else
    {
      //vs ai match
      game.currentRound = GameRound.aiMatch(ArtificialPlayer(difficulty));
    }
  }

  /// Called by the GameButton widget when it is clicked. Triggers the logic for a player move.
  void SquareClicked(SquarePointer sq, BuildContext context)
  {
      //if the square is empty, register the players move, else do nothing
      if(sq.model.isEmpty() && game.currentRound.playerCanMove())
      {
        //register a new move with the appropriate player
        sq.model.RegisterMove(game.currentRound.p1turn ? "X" : "O");

        if(!game.currentRound.GameFinished()) // switch the turn if the game has not finished yet
        {
          //toggle the turn to the other player
          game.currentRound.p1turn = !game.currentRound.p1turn; 

          //if the second player is ai, automatically make a move
          if(game.currentRound.AIPlayer != null) 
          {
            game.currentRound.AIPlayer!.AIMove();
          }
        }
      }
  }

  void SquareChanged(String newString, GameButton square)
  {
    square.currentState.updateContent(newString); // update the button to display the new content
  }

  void RestartClicked()
  {
    game.RestartRound();
  }

  void UndoClicked()
  {
    //check that at least one move has been made, and the ai is not currently making a turn, and the game has not finished
    if(game.currentRound.moveLog.isNotEmpty && game.currentRound.playerCanMove())
    {
      game.currentRound.UndoMove();
    }
  }

  void WinnerChanged(String result)
  {
    winnerLabel.myState.updateContent(result);
    
    //Turn the confetti on
    if(result == "X") gameScreen.confettiController.myState.switchState = true;
    else gameScreen.confettiController.myState.switchState = false;
  }

  WinLabel generateWinLabel()
  {
    winnerLabel = WinLabel();
    return winnerLabel;
  }
}
