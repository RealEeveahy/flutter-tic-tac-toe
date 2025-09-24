import '../model/game_square_model.dart';
import '../view/game_button.dart';
import 'package:flutter/material.dart';

class SquarePointer
{
  late GameButton view;
  late GameSquare model;
  SquarePointer(BuildContext context, int index)
  {
    model = GameSquare(index, this); // create the model that will handle button logic
    view = GameButton(parent: this); // create the button that will be displayed in the gridview
  }
}