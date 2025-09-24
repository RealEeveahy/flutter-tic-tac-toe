import '../main.dart';
///
/// Stores the information that will persist across game sessions
/// This includes the players win/loss record
///
class PlayerData {
  int wins, losses, draws;
  PlayerData(this.wins, this.losses, this.draws);

  //increment the stat counter, save the player data at the same time.
  void Win(){wins++; game.SavePlayerData();}
  void Lose(){losses++; game.SavePlayerData();}
  void Draw(){draws++; game.SavePlayerData();}
}