//import 'dart:io';
//import 'package:path_provider/path_provider.dart';

///
/// Defines logic for a stand-alone match
/// This includes storing a list of moves completed within the match
/// such that a move may be undone.
///
class Match {
  bool p1turn = true;
  bool p2AI = false;
}

///
/// Stores the information that will persist across game sessions
/// This includes the players win/loss record
///
class PlayerData {
  int wins, losses, draws;
  PlayerData(this.wins, this.losses, this.draws);
}

///
/// Initializes and stores the game grid
///
class GameGrid {
  var grid = Map<(int,int),GameSquare>();

  /// Initialize and populate the grid
  GameGrid()
  {
    for(int x = 0; x <= 2; x++)
    {
      for(int y = 0; y <= 2; y++)
      {
        grid[(x,y)] = GameSquare(x, y);
      }
    }
  }

  /// Clear all the squares within a game grid
  void ClearAll()
  {
    grid.forEach((key, value) {
        value.SetContent("");
      }
    );
  }
}

///
/// Defines logic for a game-square, for which there will be 9
/// This includes the position, content, and win-condition checks of the square
/// 
class GameSquare {
  (int,int)? position;
  String content = "";

  GameSquare(int xPosition, int yPosition)
  {
    position = (xPosition, yPosition);
  }
  void SetContent(String newContent)
  {
    content = newContent;
  }
  bool isEmpty() { return content == "" ? true : false; }
}

///
/// Defines logic for the in-game AI player
/// This includes the selected difficulty, random choice, and strategised choice methods
/// 
class ArtificialPlayer {
  /// difficulty stored as an integer 0-2: 0=easy, 1=medium, 2=hard
  int difficulty = 0;
  /// stores the last move difficulty completed by a medium difficulty AI
  int tempDiff = 0;

  ArtificialPlayer(this.difficulty);

  void ChooseMove()
  {
    if(difficulty == 0){ //easy
      RandomMove();
    }
    else if(difficulty == 1){ //medium
      if(tempDiff == 0){
        RandomMove();
        tempDiff+=1;
      }
      else{
        StrategicMove();
        tempDiff=0;
      }
    }
    else{ //hard
      StrategicMove();
    }
  }
  void RandomMove()
  {

  }
  void StrategicMove()
  {

  }
}

///
/// Defines logic for an individual move including player and position
///
class Move {
  GameSquare sq;
  String player;
  Move(this.sq, this.player);
}