//This file will be (somewhat) treated as global variable storage
import 'package:shared_preferences/shared_preferences.dart';
import 'game_grid_model.dart';
import '../viewmodel/game_updates.dart';
import 'round_model.dart';
import 'player_data_model.dart';

///
/// Defines the logic for a game session (app instance)
/// including instantiating necessary variables and storing current information.
/// 
class PlayerSession {
  late PlayerData data;
  late GameRound currentRound;
  late GameGrid grid;

  PlayerSession()
  {
    //initialise new player data, if nothing is found in storage, an empty playerdata will be created
    LoadPlayerData();

    grid = GameGrid();
  }  
  PlayerSession.doNotLoad()
  {
    grid = GameGrid.noUI();
    data = PlayerData(0, 0, 0);
  }
  static Future<PlayerSession> create() async {
    PlayerSession session = PlayerSession();
    await Future.delayed(Duration(seconds: 2)); // Simulate async work
    return session;
  }
  //avoid typing "grid.grid" everywhere
  Map GetGrid()
  {
    return grid.grid;
  }

  void RestartRound({bool ui = true})
  {
    //reset the grid
    grid.ClearAll();

    //allows for unit testing
    if(ui) updateHandler.WinnerChanged("");

    //start a new round, carry over the same AI settings
    if(currentRound.AIPlayer == null) { currentRound = GameRound(); }
    else { currentRound = GameRound.aiMatch(currentRound.AIPlayer); }
  }
  Future<void> LoadPlayerData()
  async {
    final prefs = await SharedPreferences.getInstance();
    
    //get each of the player statistics from the preferences
    final w = prefs.getInt('wins') ?? 0;
    final l = prefs.getInt('losses') ?? 0;
    final d = prefs.getInt('draws') ?? 0;

    data = PlayerData(w, l, d);
  }
  Future<void> SavePlayerData()
  async {
    final prefs = await SharedPreferences.getInstance();
    
    //store each of the player statistics in the preferences
    await prefs.setInt('wins', data.wins);
    await prefs.setInt('losses', data.losses);
    await prefs.setInt('draws', data.draws);
  }
}



