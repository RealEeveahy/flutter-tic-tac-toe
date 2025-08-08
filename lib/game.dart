//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'main.dart';

//instantiate the user controls and game session classes
UserControls controls = UserControls();
PlayerSession game = PlayerSession();

///
/// Defines logic that is interacted with through the user interface.
/// This includes menu choices and gameplay
///
class UserControls {
  void PlayerSelected(bool ai, var context)
  {
    if (ai) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DifficultyScreen()));
    }
    else {
      game.currentMatch = Match();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
    }
  }
  void DifficultySelected(int d, var context)
  {
    //insantiate a match with the ai of selected difficulty
    game.currentMatch = Match.aiMatch(ArtificialPlayer(d));
    Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
  }
  void GameSquareClicked(GameSquare clicked, var context)
  {
    if(clicked.isEmpty())
    {
      clicked.content;
    }
  }
}

///
/// Defines the logic for a game session
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

    // //initialise the game grid
    // for(int x = 1; x <= 3; x++)
    // {
    //   for(int y = 1; y <= 3; y++)
    //   {
    //     grid[(x,y)] = GameSquare(x, y);
    //   }
    // }
  }
  PlayerSession.ExistingSession(PlayerData file)
  {
    data = file;
  }
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
  //OutlinedButton? myButton;
  //ButtonText? textWidget;
  GameButton? myButton;

  // constructor is called in the gridview method of the GameScreen widget such that the squares are made when the 
  // screen is
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
    x=subindex; //x is the remainder after removing each row
    position = (x, y);

    //create the textwidget beforehand such that it can be referred to by other methods within the class
    //textWidget = ButtonText();

    //Create the button
    // myButton = OutlinedButton(
    //   onPressed: () {      
    //     controls.GameSquareClicked(this, context);
    //   },
    //   style: ButtonStyle(
    //     shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
    //   ),
    //   child : textWidget
    // );

    myButton = GameButton();

    game.AddToGrid(x,y,this);
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