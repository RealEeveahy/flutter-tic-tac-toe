import 'game_square_model.dart';

class GameGrid {
  Map grid = <(int,int),GameSquare>{};

  GameGrid()
  {
    /// necessary empty constructor so that noUi may exist for testing
  }
  GameGrid.noUI()
  {
    //default grid population (with no ui attachment)
    int i = 0;
    while(i < 9)
    {
      GameSquare.noUI(i, this);
      i++;
    }
  }

  /// Add a square to the game grid at the appropriate position, used by the GameSquare constructor
  void AddToGrid(int x, int y, GameSquare sq)
  {
    grid[(x,y)] = sq;
  }
  /// Clear all the squares within a game grid
  void ClearAll({bool ui = true})
  {
    grid.forEach((key, value) {
        value.SetContent("", ui:ui);
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