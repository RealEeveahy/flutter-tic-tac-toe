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
  bool roundComplete = false;
  ArtificialPlayer? AIPlayer;
  List<Move> moveLog = List.empty(growable: true);

  GameRound();
  GameRound.aiMatch(this.AIPlayer);

  bool GameFinished()
  {
    if(moveLog.length == 9) //grid has been filled
    {
      String check = game.grid.CheckForWin();
      if(check != "")
      {
        //if any player has won on the 9th move, return true and complete regular game won behaviour
        updateHandler.WinnerChanged(check);
        roundComplete = true;
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
        updateHandler.WinnerChanged(check);
        roundComplete = true;
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
    if(roundComplete)
    {
      //game is finished, moves cannot be made 
      return false;
    }
    else if(p1turn && AIPlayer != null) {
      //player 1's turn, player 2 is ai
      return true;
    }
    else if(AIPlayer == null) {
      //both players are human - player should always have control
      return true;
    }
    else {
      //player 2's turn, player 2 is ai
      return false;
    }
  }

  void UndoMove()
  {
    moveLog.last.sq.SetContent(""); //Set the content of the last assigned square to empty
    moveLog.removeLast(); //pop it from the move log

    //repeat the same logic again if player 2 is ai.
    //first run will remove the ai's move, second will remove the players
    if(AIPlayer != null)
    {
      moveLog.last.sq.SetContent("");
      moveLog.removeLast();
    }
    else{
      //flip the turn back to the person who made the undo. 
      //this shouldn't be necessary in a vs ai game because the action removes the last two moves and
      //can only be used on the players turn, therefore already being in the correct conditions
      game.currentRound.p1turn = !game.currentRound.p1turn; 
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