import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/model/session_model.dart';
import 'package:tic_tac_toe/main.dart';

///
/// Not working as of 12/9. Cannot instantiate the session
///
void main()
{
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await InitializeData();
  });
  // Test PDE: Player data is empty on instantiation.
  test('Player data is empty on instantiation of a new session.', () {
    expect(
      game.data.wins == 0 && game.data.losses == 0 && game.data.draws == 0,
      isTrue,
    );
  });
  // Test PDL: Player data is loaded on instantiation.
  test('Player data is loaded on instantiation of a new session.', () async {
    // preconditions, 1 win, 1 loss, data saved, session ended.
    game.data.Win();
    game.data.Lose();
    game.SavePlayerData();
    
    //reload the data 
    await InitializeData();

    expect(
      game.data.wins == 1 && game.data.losses == 1 && game.data.draws == 0,
      isTrue,
    );
  });
}

Future<void> InitializeData() async {
  await Future.delayed(Duration(seconds: 2));
  game = await PlayerSession.create();
}