//This file will be (somewhat) treated as global variable storage
import 'package:tic_tac_toe/model/game_grid.dart';
import 'round.dart';

// instantiate the user controls and game session classes
PlayerSession game = PlayerSession();

///
/// Defines the logic for a game session (app instance)
/// including instantiating necessary variables and storing current information.
/// 
class PlayerSession {
  PlayerData? data;
  late GameRound currentRound;
  late GameGrid grid;
  //store each game square in a format that may be referred to by other classes

  //constructor should be parsed save data if any is found. create a new playerdata if one does not exist
  PlayerSession()
  {
    //initialise new player data
    data = PlayerData(0, 0, 0);
    grid = GameGrid();
  }
  PlayerSession.ExistingSession(PlayerData file)
  {
    data = file;
  }
  //avoid typing "grid.grid" everywhere
  Map GetGrid()
  {
    return grid.grid;
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

