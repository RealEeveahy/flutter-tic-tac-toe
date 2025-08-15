//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import '../viewmodel/game_updates.dart';
import 'model/game_ai.dart';

// instantiate the user controls and game session classes
PlayerSession game = PlayerSession();

///
/// Defines the logic for a game session (app instance)
/// including instantiating necessary variables and storing current information.
/// 
class PlayerSession {
  Match? currentMatch;
  PlayerData? data;
  //store each game square in a format that may be referred to by other classes
  var grid = <(int,int),GameSquare>{};

  //constructor should be parsed save data if any is found. create a new playerdata if one does not exist
  PlayerSession()
  {
    //initialise new player data
    data = PlayerData(0, 0, 0);
  }
  PlayerSession.ExistingSession(PlayerData file)
  {
    data = file;
  }

  // add a square to the game grid at the appropriate position, used by the GameSquare constructor
  void AddToGrid(int x, int y, GameSquare sq)
  {
    grid[(x,y)] = sq;
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
/// Defines logic for a stand-alone match
/// This includes storing a list of moves completed within the match
/// such that a move may be undone.
///
class Match {
  bool p1turn = true;
  ArtificialPlayer? AIPlayer;
  List<Move> moveLog = List.empty(growable: true);

  Match();
  Match.aiMatch(this.AIPlayer);

  bool playerCanMove()
  {
    if(p1turn && game.currentMatch!.AIPlayer != null) {
      //player 1's turn, player 2 is ai
      return true;
    }
    else if(game.currentMatch!.AIPlayer == null) {
      //both players are human - player should always have control
      return true;
    }
    else {
      //player 2's turn, player 2 is ai
      return false;
    }
  }

  void checkForWin()
  {

  }
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
/// Defines logic for a game-square, for which there will be 9
/// This includes the position, content, and win-condition checks of the square
/// 
class GameSquare {
  (int,int)? position;
  String content = "";
  late SquarePointer parent;

  // constructor is called in the gridview method of the GameScreen widget such that the squares are made when the 
  // screen is loaded
  GameSquare(int index, this.parent)
  {
    // get the position of the square from the index. this was the easiest way i could think
    // of using simply the index
    int x=0,y=0,subindex=index;
    while(subindex > 3)
    {
      subindex -=3;
      y+=1;
    }
    x=subindex; // x is the remainder after removing each row
    position = (x, y); // store the position within the square for reference

    game.AddToGrid(x,y,this); // add the square to the game grid
  }
  
  /// Register a move to the moveLog AND update the content of the button
  void RegisterMove(String player)
  {
    game.currentMatch!.moveLog.add(Move(this, player));
    SetContent(player);
  }

  /// Sets the content of the button, used by the player, AI, and clearing methods
  void SetContent(String newContent) 
  { 
    content = newContent;
    updateHandler.SquareChanged(newContent, parent.view);
  }

  // check if the square is empty, determines if a move can be placed here
  bool isEmpty() { return content == "" ? true : false; }
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