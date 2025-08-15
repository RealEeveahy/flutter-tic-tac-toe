import 'package:flutter/material.dart';
import '../view/mode_select.dart';
import '../view/game_screen.dart';
import '../view/difficulty_select.dart';


NavigationControl nav = NavigationControl();

class NavigationControl 
{
  void ModeSelect(var context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ModeSelectScreen()));
  }
  void DifficultySelect(var context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const DifficultyScreen()));
  }
  void ToGame(var context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
  }
}