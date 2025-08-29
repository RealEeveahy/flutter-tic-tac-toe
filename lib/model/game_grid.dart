import '../viewmodel/game_updates.dart';
import 'round.dart';
import '../main.dart';


class GameGrid {
  Map grid = <(int,int),GameSquare>{};

  /// Add a square to the game grid at the appropriate position, used by the GameSquare constructor
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
  //// Exists to simplify the function below it as accessing grid squares from the map receives them as a generic type therefore
  /// I would otherwise have to declare each square check as a square before comparison ( i think ) 
  String Read(int x, int y)
  {
    GameSquare readAt = grid[(x,y)];
    return readAt.content;
  }
  /// Scan through possible win conditions in the grid
  /// My logic here: if all the grid squares in a given row/column are the same, return that columns entry to get the winner
  /// if an empty string is returned it is considered a false value by the method calling this one.
  String CheckForWin()
  {
    int x=0;
    while(x<3)
    {
      ///check verticals
      if(Read(x,0) == Read(x,1) && Read(x,1) == Read(x,2))
      {
        return Read(x,0);
      }
      //check horizontals
      if(Read(0,x) == Read(1,x) && Read(1,x) == Read(2,x))
      {
        return Read(0,x);
      }
      x++;
    }

    //check diagonals
    if(Read(0,0) == Read(1,1) && Read(1,1) == Read(2,2)) 
    {
      return Read(0,0);
    }
    if(Read(2,0) == Read(1,1) && Read(1,1) == Read(0,2)) 
    {
      return Read(2,0);
    }
    return "";
  }
}

///
/// Defines logic for a game-square, for which there will be 9
/// This includes the position, content, and win-condition checks of the square
/// 
/// -- Instantiated as part of the game screen code, not on entry
/// 
class GameSquare {
  late (int,int) position;
  String content = "";
  late SquarePointer parent;

  // constructor is called in the gridview method of the GameScreen widget such that the squares are made when the 
  // screen is loaded
  GameSquare(int index, this.parent)
  {
    position=GetPosition(index);
    game.grid.AddToGrid(position.$1,position.$2,this); // add the square to the game grid
  }

  // constructor for unit testing
  GameSquare.noUI(int index, GameGrid grid)
  {
    position=GetPosition(index);
    grid.AddToGrid(position.$1,position.$2,this); // add the square to the game grid
  }

  (int,int) GetPosition(int index)
  {
    // get the position of the square from the index. this was the easiest way i could think
    // of using simply the index
    int x=0,y=0,subindex=index;
    while(subindex > 2)
    {
      subindex -=3;
      y+=1;
    }
    x=subindex; // x is the remainder after removing each row
    return (x, y); // store the position within the square for reference
  }
  
  /// Register a move to the moveLog AND update the content of the button
  void RegisterMove(String player)
  {
    game.currentRound.moveLog.add(Move(this, player));
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