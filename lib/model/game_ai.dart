import 'dart:math'; //for random number generation
import 'session.dart';


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

    while(game.grid.Read(randomX, randomY) != "")
    {
      randomX = rng.nextInt(3);
      randomY = rng.nextInt(3);
    }
    return (randomX, randomY);
  }

  (int,int) GetStrategicMove()
  {
    if(TwoInARow()) // if either player has two in a row, place in the remaining square
    {
      return storedPosition;
    }
    else if(difficulty ==0) // if there is a move that creates two lines of two, place there
    {
      return (1, 1);
    }
    else if(game.GetGrid()[(1,1)]!.isEmpty()) // if the centre square is empty, place there
    {
      return (1, 1);
    }  
    else if(CheckCorners()) // play in the opposite corner to the opponent, or any corner if one is free
    {
      return storedPosition;
    }
    else // choose any empty square if no other condition is met
    {
      return GetRandomMove();
    }
  }
  void AIMove()
  {
    // get a move and register it in the grid  
    game.GetGrid()[(ChooseMove())]!.RegisterMove("O");

    //swap the turn back to player 1 if the Ai did not win this turn
    if(!game.currentRound.GameFinished())
    {
      game.currentRound.p1turn = !game.currentRound.p1turn;
    }
  }
  bool TwoInARow()
  {
    //check horizontals and verticals
    int x=0;
    while(x < 3)
    {
      if(TwoInARowHelper((x,0), (x,1), (x,2))) return true; 
      else if(TwoInARowHelper((0,x), (1,x), (2,x))) return true; 
      x++;
    }

    //check diagonals
    if(TwoInARowHelper((0,0), (1,1), (2,2))) return true;
    else if(TwoInARowHelper((0,2), (1,1), (2,0))) return true;
    else return false;
  }
  bool TwoInARowHelper((int,int) sq1, (int,int) sq2, (int,int) sq3)
  {
    List<(int,int)> empties = List.empty(growable: true);
    List<(int,int)> occupied = List.empty(growable: true);
    if(game.GetGrid()[sq1].isEmpty()) empties.add(sq1); else occupied.add(sq1);
    if(game.GetGrid()[sq2].isEmpty()) empties.add(sq2); else occupied.add(sq2);
    if(game.GetGrid()[sq3].isEmpty()) empties.add(sq3); else occupied.add(sq3);

    //return early if the row does not have 2 filled squares
    if(empties.length != 1) return false;
    else {
      //check if the two occupied squares have the same content
      if(game.grid.Read(occupied[0].$1, occupied[0].$2) == game.grid.Read(occupied[1].$1, occupied[1].$2))
      {
        storedPosition = empties[0];
        return true;
      }
      else return false;
    }
  }
  bool CheckCorners()
  {
    //sort the corners by occupied and empty
    List<(int,int)> empties = List.empty(growable: true);
    List<(int,int)> occupied = List.empty(growable: true);
    if(game.GetGrid()[(0,0)].isEmpty()) empties.add((0,0)); else occupied.add((0,0));
    if(game.GetGrid()[(2,0)].isEmpty()) empties.add((2,0)); else occupied.add((2,0));
    if(game.GetGrid()[(0,2)].isEmpty()) empties.add((0,2)); else occupied.add((0,2));
    if(game.GetGrid()[(2,2)].isEmpty()) empties.add((2,2)); else occupied.add((2,2));

    if(empties.isEmpty) return false; //return early if no corners are free
    else{
      List<(int,int)> opposites = empties;
      for(final e in occupied)
      {
        if(game.grid.Read(e.$1, e.$2) == "O")
        {
          //if an occupied corner is owned by the ai, remove it's opposite from the selection pool
          int oX=0, oY=0;
          if(e.$1 == 0) oX = 2;
          if(e.$2 == 0) oY = 2;
          (int,int) oppositeCorner = (oX,oY);
          
          if(opposites.contains(oppositeCorner)) opposites.remove(oppositeCorner);
        }
      }
      if(empties.length > 1 && empties.length < 4) // dont search for an 'opposite' if there is no occupied corners / only one empty corner
      {
        // if the opponent has played in a corner, place in the opposite corner
        storedPosition = opposites[rng.nextInt(opposites.length)];
        return true;
      }
      else { 
        // if any corner is free, place it there
        storedPosition = empties[rng.nextInt(empties.length)];
        return true;
      }
    }
  }
}
