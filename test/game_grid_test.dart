import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/game_grid.dart';

void main(){

  GameGrid testGrid = GameGrid();
  //default grid population (with no ui attachment)
  int i = 0;
  while(i < 9)
  {
    GameSquare.noUI(i, testGrid);
  }
  setUp(() {
    testGrid.ClearAll();
  });

  // Test 1: Grid has the correct number of squares
  test('grid length is equal to 9 with default instantiation', () {
    expect(
      testGrid.grid.entries.length == 9,
      isTrue,
    );
  });

  // Test 2: ReadAt() Returns the appropriate square content (X)
    test('A given square contains the content that was applied to every square', () {
      testGrid.grid.forEach((key, value) {
        value.content="X";
      }
      );
      expect(
        testGrid.Read(1, 1) == "X",
        isTrue,
      );
  });
  // Test 3: ReadAt() Returns the appropriate square content (empty)
    test('A given square is empty after contents were cleared', () {
      testGrid.grid[(1,1)].content = "X";
      testGrid.ClearAll();
      expect(
        testGrid.Read(1, 1) == "",
        isTrue,
      );
  });
}