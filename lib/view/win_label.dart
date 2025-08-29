import 'package:flutter/material.dart';

class WinLabel extends StatefulWidget {
  late _WinLabelState myState;
  WinLabel({super.key});

  @override
  State createState()
  // ignore: no_logic_in_create_state
  {
    myState=_WinLabelState();
    return myState;
  }
}

class _WinLabelState extends State<WinLabel>
{
  String content = "";
  bool isVisible = false;
  void updateContent(String result) { setState(() {
    if (result == "") {isVisible=false;} //hide the label
    else {
      isVisible=true;
      if(result == "X" || result == "O") content = "'$result' Wins !"; //display winner
      else content = result; //set label content to draw text
      }
  });}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Visibility(
        visible: isVisible,
        child: Text(content)
      )
    );
  }
}