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
  void updateContent(String newContent) { setState(() {
    content = newContent;
    if (newContent == "") {isVisible=false;}
    else {isVisible=true;}
  });}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Visibility(
        visible: isVisible,
        child: Text("'$content' Wins !")
      )
    );
  }
}