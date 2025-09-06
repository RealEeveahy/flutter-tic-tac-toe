import 'game_square.dart';

///
/// Defines logic for an individual move including player and position
///
class Move {
  GameSquare sq;
  String player;

  ///Constructor: Takes a GameSquare and Player name as input
  Move(this.sq, this.player);
}