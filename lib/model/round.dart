import 'package:tic_tac_toe/model/game_ai.dart';
import 'package:tic_tac_toe/viewmodel/game_updates.dart';
import '../model/session.dart';
import 'game_grid.dart';

///
/// Defines logic for a stand-alone match
/// This includes storing a list of moves completed within the match
/// such that a move may be undone.
///
class GameRound {
  bool p1turn = true;
  ArtificialPlayer? AIPlayer;
  List<Move> moveLog = List.empty(growable: true);

  GameRound();
  GameRound.aiMatch(this.AIPlayer);

  bool GameFinished()
  {
    print("\n Checking for a winner...");
    if(moveLog.length == 9) //grid has been filled
    {
      String check = game.grid.CheckForWin();
      if(check != "")
      {
        //if any player has won on the 9th move, return true and complete regular game won behaviour
        print("$check wins in ${game.currentRound.moveLog.length} moves. \n");
        updateHandler.WinnerChanged(check);
        return true;
      }
      else
      {
        //if no player has won on the 9th move, return true and complete game draw behaviour
        return true;
      }
    }
    else if (moveLog.length >= 5) // at least 3 moves from player 1
    {
      String check = game.grid.CheckForWin();
      if(check != "") // a winner is found
      {
        print("$check wins in ${game.currentRound.moveLog.length} moves. \n");
        updateHandler.WinnerChanged(check);
        return true;
      }
      else { print("\n No winner found."); return false; } //no winner yet
    }
    else // don't check for win if there hasnt been enough moves for either player to win.
    {
      print("\n Not enough moves yet.");
      return false;
    }
  }

  bool playerCanMove()
  {
    if(p1turn && game.currentRound.AIPlayer != null) {
      //player 1's turn, player 2 is ai
      return true;
    }
    else if(game.currentRound.AIPlayer == null) {
      //both players are human - player should always have control
      return true;
    }
    else {
      //player 2's turn, player 2 is ai
      return false;
    }
  }
}

///
/// Defines logic for an individual move including player and position
///
class Move {
  GameSquare sq;
  String player;

  ///Constructor: Takes a GameSquare and Player name as input
  Move(this.sq, this.player);
}