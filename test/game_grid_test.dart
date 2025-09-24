import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/game_grid_model.dart';

void main(){
  GameGrid grid = GameGrid.noUI();
  setUp(() {

  });

  // Test GL: Grid has the correct number of squares
  test('grid length is equal to 9 with default instantiation', () {
    expect(
      grid.grid.entries.length,
      9,
    );
  });

  // Test GR: Read() Returns the appropriate square content (X)
    test('A given square contains the content that was applied to every square', () {
      grid.grid.forEach((key, value) {
        value.content="X";
      }
      );
      expect(
        grid.Read(1, 1) == "X",
        isTrue,
      );
  });
  // Test CAR: Read() Returns the appropriate square content (empty) after ClearAll()
    test('A given square is empty after contents were cleared', () {
      grid.ClearAll(ui:false);
      expect(
        grid.Read(1, 1) == "",
        isTrue,
      );
  });
}