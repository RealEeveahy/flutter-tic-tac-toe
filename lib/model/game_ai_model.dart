import 'dart:math'; //for random number generation
import '../main.dart';
import 'game_grid_model.dart';

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

  GameGrid grid;

  ArtificialPlayer(this.difficulty, this.grid);

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
    List<(int,int)> empties = List.empty(growable: true);
    grid.grid.forEach((key, value) {
        if(value.content == "") empties.add(key);
      }
    );
    return empties[rng.nextInt(empties.length)];
  }

  (int,int) GetStrategicMove()
  {
    if(TwoInARow()) // if either player has two in a row, place in the remaining square
    {
      return storedPosition;
    }
    else if(TwoLines()) // if there is a move that creates two lines of two, place there
    {
      // note, i cant think of any situation that could occur on a 3x3 board that would enter this logic
      // where it didnt already enter the condition above. not with the ai player going second at least
      return storedPosition;
    }
    else if(grid.Read(1,1) == "") // if the centre square is empty, place there
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
    grid.grid[(ChooseMove())]!.RegisterMove("O");

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
    if(grid.grid[sq1].isEmpty()) empties.add(sq1); else occupied.add(sq1);
    if(grid.grid[sq2].isEmpty()) empties.add(sq2); else occupied.add(sq2);
    if(grid.grid[sq3].isEmpty()) empties.add(sq3); else occupied.add(sq3);

    //return early if the row does not have 2 filled squares
    if(empties.length != 1) return false;
    else {
      //check if the two occupied squares have the same content
      if(grid.Read(occupied[0].$1, occupied[0].$2) == grid.Read(occupied[1].$1, occupied[1].$2))
      {
        storedPosition = empties[0];
        return true;
      }
      else return false;
    }
  }
  bool TwoLines()
  {
    List<(int,int)> owned = List.empty(growable: true);
    List<(int,int)> empties = List.empty(growable: true);
    grid.grid.forEach((key, value) {
        if(value.content == "O") owned.add(key);
        if(value.content == "") empties.add(key);
      }
    );

    //returns early if the ai has not placed 2 moves - would be impossible to create two lines of two
    if(owned.length < 2) return false;
    else {
      List<(int,int)> playable = List.empty(growable: true);

      /// Logic here:
      /// a given empty square is considered 'playable' if 2+ of its axes meet the following conditions:
      /// The axis contains 1 'O' and 0 'X's.
      /// A row will never be a 'row of two' if the opponent has played in that row.
      for(final e in empties)
      {
        int horizontal=0, vertical=0, diagonal=0;

        horizontal += TwoLinesHelper(e, 'x');
        vertical += TwoLinesHelper(e, 'y');
        diagonal += TwoLinesHelper(e, 'z');

        if((horizontal + vertical + diagonal) > 1)
        {
          playable.add(e);
        }
      }
      /// Choose a random marked square to play in
      if(playable.isNotEmpty)
      {
        storedPosition = playable[rng.nextInt(playable.length)];
        return true;
      }
      else return false;
    }
  }
  int TwoLinesHelper((int,int) sq, String axis)
  {
    String c1="",c2="",c3="";
    if(axis=='x')
    {
      c1 = grid.Read(0,sq.$2);
      c2 = game.grid.Read(1,sq.$2);
      c3 = game.grid.Read(2,sq.$2);
    }
    else if(axis=='y')
    {
      c1 = grid.Read(sq.$1,0);
      c2 = grid.Read(sq.$1,1);
      c3 = grid.Read(sq.$1,2);
    }
    else if(axis=='z')
    {
      if(sq != (1,1)) //regular diagonals logic
      {
        if(sq.$1 == 1 || sq.$2 == 1) return 0; // early exit if square is not a corner - does not have a diagonal
        else {
          c1 = grid.Read(sq.$1,sq.$2);
          c2 = grid.Read(1,1);
          (int,int) oc = GetOppositeCorner(sq);
          c3 = grid.Read(oc.$1,oc.$2);
        }
      }
      else //centre square logic (2 diagonals) - only logic route where 2 'TwoLines' may be found with 1 scan
      {
        int diagonals = 0;
        //diagonal 1
        if( (grid.Read(0,0) != 'X' && grid.Read(2,2) != 'X') &&
          (grid.Read(0,0) == 'O' || grid.Read(2,2) == 'O')) 
          diagonals++;
        //diagonal 2
        if( (grid.Read(0,2) != 'X' && grid.Read(2,0) != 'X') &&
          (grid.Read(0,2) == 'O' || grid.Read(2,0) == 'O')) 
          diagonals++;

        return diagonals;
      }
    }
    if(c1=='X' || c2=='X' || c3=='X') return 0; //return early if any square in the current check is owned by player 1
    else if(c1=='O' || c2=='O' || c3=='O') return 1; //'mark' the axis if it contains an AI owned square
    else return 0; //for cases where the row is entirely empty - does not fit this criteria
  }
  bool CheckCorners()
  {
    //sort the corners by occupied and empty
    List<(int,int)> empties = List.empty(growable: true);
    List<(int,int)> occupied = List.empty(growable: true);
    if(grid.grid[(0,0)].isEmpty()) empties.add((0,0)); else occupied.add((0,0));
    if(grid.grid[(2,0)].isEmpty()) empties.add((2,0)); else occupied.add((2,0));
    if(grid.grid[(0,2)].isEmpty()) empties.add((0,2)); else occupied.add((0,2));
    if(grid.grid[(2,2)].isEmpty()) empties.add((2,2)); else occupied.add((2,2));

    if(empties.isEmpty) return false; //return early if no corners are free
    else{
      List<(int,int)> opposites = empties;
      for(final e in occupied)
      {
        if(grid.Read(e.$1, e.$2) == "O")
        {
          //if an occupied corner is owned by the ai, remove it's opposite from the selection pool
          (int,int) oppositeCorner = GetOppositeCorner(e);
          
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
  //Maybe out of place in the AI class? rotates a corner position 180 degrees
  (int,int) GetOppositeCorner((int,int) corner)
  {
    int oX=0, oY=0;
    if(corner.$1 == 0) oX = 2;
    if(corner.$2 == 0) oY = 2;
    return (oX,oY);
  }
}
