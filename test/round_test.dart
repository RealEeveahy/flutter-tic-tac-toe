import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/game_ai.dart';
import 'package:tic_tac_toe/model/round.dart';

void main(){

  GameRound testRound = GameRound();
  setUp(() {
    testRound = GameRound();
  });

  // Test 1: Player can make a move on instantiation
  test('playerCanMove returns true for the default instantiation of a round', () {
    expect(
      testRound.playerCanMove(),
      isTrue,
    );
  });
  // Test 2: Player cannot make a move when the round has finished
  test('playerCanMove returns false when the round has finished', () {
    testRound.roundComplete=true;
    expect(
      testRound.playerCanMove(),
      isFalse,
    );
  });
  // Test 3: Player can always make a move when there is no AI player
  // Testing two cases at once here because the ifelse statement of the method should return true regardless of the secondary value
  test('playerCanMove returns true when AIPlayer is false and p1turn is any value', () {
    testRound.p1turn = true;
    GameRound secondCase = GameRound();
    secondCase.p1turn = false;
    expect(
      testRound.playerCanMove() && secondCase.playerCanMove(),
      isTrue,
    );
  });
  // Test 4: Player cannot make a move when there is an AI player, and it is not player 1's turn
  test('playerCanMove returns false when it is the AI players turn', () {
    testRound.AIPlayer = ArtificialPlayer(0); // default AI player insantiation
    testRound.p1turn = false;
    expect(
      testRound.playerCanMove(),
      isFalse,
    );
  }); 
  // Test 5: 
}