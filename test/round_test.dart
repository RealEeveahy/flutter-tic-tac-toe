import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/model/game_ai_model.dart';
import 'package:tic_tac_toe/model/game_grid_model.dart';
import 'package:tic_tac_toe/model/round_model.dart';
import 'package:tic_tac_toe/model/session_model.dart';

void main(){
  game = PlayerSession.doNotLoad();
  game.grid = GameGrid.noUI();
  setUp(() {
    game.currentRound = GameRound();
  });

  // Test PCM1: Player can make a move on instantiation
  test('playerCanMove returns true for the default instantiation of a round', () {
    expect(
      game.currentRound.playerCanMove(),
      isTrue,
    );
  });
  // Test PCM2: Player cannot make a move when the round has finished
  test('playerCanMove returns false when the round has finished', () {
    game.currentRound.roundComplete=true;
    expect(
      game.currentRound.playerCanMove(),
      isFalse,
    );
  });
  // Test PCM3: Player can always make a move when there is no AI player
  // Testing two cases at once here because the ifelse statement of the method should return true regardless of the secondary value
  test('playerCanMove returns true when AIPlayer is false and p1turn is any value', () {
    game.currentRound.p1turn = true;
    GameRound secondCase = GameRound();
    secondCase.p1turn = false;
    expect(
      game.currentRound.playerCanMove() && secondCase.playerCanMove(),
      isTrue,
    );
  });
  // Test PCM4: Player cannot make a move when there is an AI player, and it is not player 1's turn
  test('playerCanMove returns false when it is the AI players turn', () {
    game.currentRound.AIPlayer = ArtificialPlayer(0, game.grid); // default AI player insantiation
    game.currentRound.p1turn = false;
    expect(
      game.currentRound.playerCanMove(),
      isFalse,
    );
  }); 

  // Test GF1: GameFinished() returns false when not enough moves have been made
  test('GameFinished returns false when not enough moves have been made', () {
    game.GetGrid()[(1,1)].RegisterMove("X", ui:false); // insert 1 move
    expect(
      game.currentRound.GameFinished(ui:false),
      isFalse,
    );
  }); 
  // Test GF2: GameFinished() returns true when there is a valid winner
  test('GameFinished returns true when there is a valid winner', () {
    game.GetGrid()[(0,0)].RegisterMove("X", ui:false); // insert 1 move
    game.GetGrid()[(0,1)].RegisterMove("X", ui:false); // insert 1 move
    game.GetGrid()[(0,2)].RegisterMove("X", ui:false); // insert 1 move
    game.GetGrid()[(1,2)].RegisterMove("O", ui:false); // insert 1 move
    game.GetGrid()[(2,2)].RegisterMove("O", ui:false); // insert 1 move

    expect(
      game.currentRound.GameFinished(ui:false) && game.currentRound.roundComplete,
      isTrue,
    );
  }); 
}
