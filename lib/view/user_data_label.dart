import 'package:flutter/material.dart';

class UserDataLabel extends StatelessWidget {
  UserDataLabel({required this.labelName, super.key});

  final String labelName;
  late _DataCountState countState;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text('$labelName: '),
          UserDataCount(parent: this),
        ],
    );
  }
}

class UserDataCount extends StatefulWidget {
  late _DataCountState myState;
  UserDataCount({required this.parent, super.key});

  final UserDataLabel parent;

  @override
  State createState()
  // ignore: no_logic_in_create_state
  {
    myState=_DataCountState();
    parent.countState = myState;
    return myState;
  }
}

class _DataCountState extends State<UserDataCount>
{
  int count = 0;
  void updateCount(int setCount) { setState(() {
    count = setCount;
  });}

  @override
  Widget build(BuildContext context) {
    return Text(count.toString());
  }
}