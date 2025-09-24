import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/round_model.dart';
import 'package:tic_tac_toe/model/session_model.dart';

void main(){
  PlayerSession session = PlayerSession.doNotLoad();

  // Test RR: RestartRound() successfully resets the player turn.
  test('RestartRound() successfully resets the player turn.', () {
    session.currentRound = GameRound();
    session.currentRound.p1turn == false;
    session.RestartRound(ui:false);
    expect(
      session.currentRound.p1turn == true,
      isTrue,
    );
  });
}