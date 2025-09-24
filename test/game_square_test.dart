import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/game_square_model.dart';

void main(){
  GameSquare testsquare = GameSquare.noLogic();
  // Test GP: GetPosition() returns the correct position
  test('GetPosition() returns the correct position.', () {
    expect(
      testsquare.GetPosition(3),
      (0,1),
    );
  });

  // Test SC: SetContent() updates square content
  test('SetContent() updates square content', () {
    testsquare.SetContent("X", ui: false);
    expect(
      testsquare.content,
      "X",
    );
  });

  // Test EM: isEmpty() returns false when content has been applied
    test('isEmpty() returns false when content has been applied', () {
    expect(
      testsquare.isEmpty(),
      isFalse,
    );
  });
}