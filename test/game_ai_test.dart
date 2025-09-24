import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/game_ai_model.dart';
import 'package:tic_tac_toe/model/round_model.dart';
import 'package:tic_tac_toe/model/session_model.dart';
import 'package:tic_tac_toe/main.dart';

void main(){
  game = PlayerSession.doNotLoad();
  ArtificialPlayer ai = ArtificialPlayer(0,game.grid);
  game.currentRound = GameRound.aiMatch(ai);

  setUp(() {
    game.grid.ClearAll(ui:false);
  });

  // Test AIRM: GetRandomMove() returns a legal move
  test('GetRandomMove() returns a legal move', () {
    game.GetGrid()[(0,0)].RegisterMove("X", ui:false); // insert 1 move
    game.GetGrid()[(0,1)].RegisterMove("O", ui:false); // insert 1 move
    game.GetGrid()[(0,2)].RegisterMove("X", ui:false); // insert 1 move
    (int,int) random = ai.GetRandomMove();
    expect(
      random != (0,0) && random != (0,1) && random != (0,2),
      isTrue
    );
  });

  // Test AITR: TwoInARow() selects the expected counter move
  test('TwoInARow() selects the expected counter move', () {
    game.GetGrid()[(0,0)].RegisterMove("X", ui:false); // insert 1 move
    game.GetGrid()[(0,1)].RegisterMove("X", ui:false); // insert 1 move

    bool caught = ai.TwoInARow();
    print(ai.storedPosition);
    expect(
      caught && ai.storedPosition==(0,2),
      isTrue
    );
  });

  // Test AITL: TwoLines() selects the expected move
  test('TwoInARow() selects the expected move', () {
    game.GetGrid()[(0,0)].RegisterMove("O", ui:false); // insert 1 move
    game.GetGrid()[(1,1)].RegisterMove("X", ui:false); // insert 1 move
    game.GetGrid()[(2,2)].RegisterMove("O", ui:false); // insert 1 move

    bool caught = ai.TwoLines();
    expect(
      caught && (ai.storedPosition==(0,2) || ai.storedPosition==(2,0)),
      isTrue
    );
  });

  // Test AICC: CheckCorners() selects the expected counter move
  test('CheckCorners() selects the expected counter move', () {
    game.GetGrid()[(0,0)].RegisterMove("X", ui:false); // insert 1 move

    bool caught = ai.CheckCorners();
    print(ai.storedPosition);
    expect(
      caught && ai.storedPosition==(2,2),
      isTrue
    );
  });
}