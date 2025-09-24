import 'package:tic_tac_toe/model/session_model.dart';

import '../main.dart';
import '../viewmodel/square_pointer.dart';
import '../viewmodel/game_updates.dart';
import 'game_grid_model.dart';
import 'game_move_model.dart';
///
/// Defines logic for a game-square, for which there will be 9
/// This includes the position, content, and win-condition checks of the square
/// 
/// -- Instantiated as part of the game screen code, not on entry
/// 
class GameSquare {
  late (int,int) position;
  String content = "";
  late SquarePointer parent;

  // constructor is called in the gridview method of the GameScreen widget such that the squares are made when the 
  // screen is loaded
  GameSquare(int index, this.parent)
  {
    position=GetPosition(index);
    game.grid.AddToGrid(position.$1,position.$2,this); // add the square to the game grid
  }

  // constructor for unit testing
  GameSquare.noUI(int index, GameGrid grid)
  {
    position=GetPosition(index);
    grid.AddToGrid(position.$1,position.$2,this); // add the square to the game grid
  }

  GameSquare.noLogic();

  (int,int) GetPosition(int index)
  {
    // get the position of the square from the index. this was the easiest way i could think
    // of using simply the index
    int x=0,y=0,subindex=index;
    while(subindex > 2)
    {
      subindex -=3;
      y+=1;
    }
    x=subindex; // x is the remainder after removing each row
    return (x, y); // store the position within the square for reference
  }
  
  /// Register a move to the moveLog AND update the content of the button
  void RegisterMove(String player, {bool ui = true})
  {
    game.currentRound.moveLog.add(Move(this, player));
    SetContent(player, ui:ui);
  }

  /// Sets the content of the button, used by the player, AI, and clearing methods
  void SetContent(String newContent, {bool ui = true}) 
  { 
    content = newContent;
    if(ui) updateHandler.SquareChanged(newContent, parent.view);
  }

  // check if the square is empty, determines if a move can be placed here
  bool isEmpty() { return content == "" ? true : false; }
}