import '../game.dart';
import 'dart:math'; //for random number generation

// insantiate random number generator
var rng = Random();

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
    // get a move and register it in the grid  
    game.grid[(ChooseMove())]!.RegisterMove("O");

    //swap the turn back to player 1
    game.currentMatch!.p1turn = !game.currentMatch!.p1turn;
  }
}
