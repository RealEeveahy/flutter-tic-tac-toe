//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math'; //for random number generation

//instantiate the user controls and game session classes
UserControls controls = UserControls();
PlayerSession game = PlayerSession();

///
/// Defines logic that is interacted with through the user interface.
/// This includes menu choices and gameplay
///
class UserControls {

  /// Called in the first menu where the player may select Vs Player or Vs Computer
  void PlayerSelected(bool ai, var context)
  {
    if (ai) {
      //if vs computer is selected, go to the difficulty screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DifficultyScreen()));
    }
    else {
      //if vs player is selected, go straight to the game screen
      game.currentMatch = Match();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
    }
  }

  /// Called in the (optional) second menu where the player may select one of three difficulties for the ai
  void DifficultySelected(int d, var context)
  {
    //insantiate a match with the ai of selected difficulty
    game.currentMatch = Match.aiMatch(ArtificialPlayer(d));

    //go to the game screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
  }

  /// Called by the GameButton widget when it is clicked. Triggers the logic for a player move.
  void GameSquareClicked(GameSquare clicked, var context)
  {
    //if the square is empty, register the players move, else do nothing
    if(clicked.isEmpty() && game.currentMatch!.playerCanMove())
    {
      //register a new move with the appropriate player
      clicked.RegisterMove(game.currentMatch!.p1turn ? "X" : "O");

      //toggle the turn to the other player
      game.currentMatch!.p1turn = !game.currentMatch!.p1turn; 

      //if the second player is ai, automatically make a move
      if(game.currentMatch!.AIPlayer != null) 
      {
        game.currentMatch!.AIPlayer!.AIMove();
      }
    }
  }
}

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
  GameButton? myButton;

  // constructor is called in the gridview method of the GameScreen widget such that the squares are made when the 
  // screen is loaded
  GameSquare(int index, BuildContext context)
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

    myButton = GameButton(mySquare: this); // create the button that will be displayed in the gridview

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
    myButton!.currentState.updateContent(newContent); // update the button to display the new content
  }

  // check if the square is empty, determines if a move can be placed here
  bool isEmpty() { return content == "" ? true : false; }
}

///
/// Defines logic for the in-game AI player
/// This includes the selected difficulty, random choice, and strategised choice methods.
/// 
class ArtificialPlayer {
  /// difficulty stored as an integer 0-2: 0=easy, 1=medium, 2=hard
  int difficulty = 0;
  /// stores the last move difficulty completed by a medium difficulty AI
  int tempDiff = 0;

  (int,int) storedPosition = (0,0);

  ArtificialPlayer(this.difficulty);

  /// Get a move based on AI difficulty
  (int,int) ChooseMove()
  {
    if(difficulty == 0){ //easy
      return GetRandomMove();
    }
    else if(difficulty == 1){ //medium
      if(tempDiff == 0){
        tempDiff+=1;
        return GetRandomMove();
      }
      else{
        tempDiff=0;
        return GetStrategicMove();
      }
    }
    else{ //hard
      return GetStrategicMove();
    }
  }

  (int,int) GetRandomMove()
  {
    var rng = Random();
    int randomX = rng.nextInt(3), randomY = rng.nextInt(3);

    while(!game.grid[(randomX, randomY)]!.isEmpty())
    {
      randomX = rng.nextInt(3);
      randomY = rng.nextInt(3);
    }
    return (randomX, randomY);
  }

  (int,int) GetStrategicMove()
  {
    if(difficulty ==0) // if either player has two in a row, place in the remaining square
    {
      return (1, 1);
    }
    else if(difficulty ==0) // if there is a move that creates two lines of two, place there
    {
      return (1, 1);
    }
    else if(game.grid[(1,1)]!.isEmpty()) // if the centre square is empty, place there
    {
      return (1, 1);
    }  
    else if(difficulty ==0) // if the opponent has played in a corner, place in the opposite corner
    {
      return (1, 1);
    }  
    else if(difficulty ==0) // if any corner is free, place it there
    {
      return (1, 1);
    }
    else // choose any empty square if no other condition is met
    {
      return GetRandomMove();
    }
  }
  void AIMove()
  {
    game.grid[(ChooseMove())]!.RegisterMove("O");
    game.currentMatch!.p1turn = !game.currentMatch!.p1turn; //
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